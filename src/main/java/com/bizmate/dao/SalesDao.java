package com.bizmate.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import com.bizmate.model.Sale;
import com.bizmate.util.DbConnection;

//매출 저장과 목록 조회, 수정, 삭제, CSV 일괄 저장
public class SalesDao {
    public void insert(Sale sale) throws SQLException {
        insertAll(List.of(sale));
    }

    public List<Sale> findAll() throws SQLException {
        String sql = "SELECT sale_id, sale_date, product_name, quantity, amount, order_no, order_channel FROM sales ORDER BY sale_date DESC, sale_id";
        List<Sale> sales = new ArrayList<>();

        try (Connection connection = DbConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql);
             ResultSet result = statement.executeQuery()) {
            while (result.next()) {
                LocalDateTime saleDate = result.getObject("sale_date", LocalDateTime.class);
                Sale sale = new Sale(saleDate, result.getString("product_name"), result.getInt("quantity"), result.getLong("amount"), result.getString("order_no"), result.getString("order_channel"));
                sale.setSaleId(result.getString("sale_id"));
                sales.add(sale);
            }
        }

        return sales;
    }

    public void insertAll(List<Sale> sales) throws SQLException {
        writeChanges(sales, List.of(), new String[0]);
    }

    public void saveChanges(List<Sale> updatedSales, String[] deletedSaleIds) throws SQLException {
        writeChanges(List.of(), updatedSales, deletedSaleIds);
    }

    private static synchronized void writeChanges(List<Sale> newSales, List<Sale> updatedSales, String[] deletedSaleIds) throws SQLException {
        String insertSql = "INSERT INTO sales (sale_date, product_name, quantity, amount, order_channel, sale_id, order_no) VALUES (?, ?, ?, ?, ?, ?, ?)";
        String updateSql = "UPDATE sales SET sale_date = ?, product_name = ?, quantity = ?, amount = ?, order_channel = ? WHERE sale_id = ?";
        String deleteSql = "DELETE FROM sales WHERE sale_id = ?";

        try (Connection connection = DbConnection.getConnection()) {
            connection.setAutoCommit(false);

            try {
                try (PreparedStatement insert = connection.prepareStatement(insertSql);
                     PreparedStatement update = connection.prepareStatement(updateSql);
                     PreparedStatement delete = connection.prepareStatement(deleteSql)) {
                    for (Sale sale : newSales) {
                        setSaleValues(insert, sale);
                        insert.setString(7, sale.getOrderNo());
                        insert.addBatch();
                    }
                    if (!newSales.isEmpty()) {
                        insert.executeBatch();
                    }

                    for (Sale sale : updatedSales) {
                        setSaleValues(update, sale);
                        if (update.executeUpdate() != 1) {
                            throw new SQLException("수정할 매출 내역이 없습니다.");
                        }
                    }

                    for (String saleId : deletedSaleIds) {
                        delete.setString(1, saleId);
                        if (delete.executeUpdate() != 1) {
                            throw new SQLException("삭제할 매출 내역이 없습니다.");
                        }
                    }
                }

                checkTotalAmount(connection);
                connection.commit();
            } catch (SQLException e) {
                try {
                    connection.rollback();
                } catch (SQLException rollbackError) {
                    e.addSuppressed(rollbackError);
                }
                throw e;
            }
        }
    }

    private static void setSaleValues(PreparedStatement statement, Sale sale) throws SQLException {
        statement.setObject(1, sale.getSaleDate());
        statement.setString(2, sale.getProductName());
        statement.setInt(3, sale.getQuantity());
        statement.setLong(4, sale.getAmount());
        statement.setString(5, sale.getOrderChannel());
        statement.setString(6, sale.getSaleId());
    }

    private static void checkTotalAmount(Connection connection) throws SQLException {
        String sql = "SELECT COALESCE(SUM(amount), 0) FROM sales";

        try (PreparedStatement statement = connection.prepareStatement(sql);
             ResultSet result = statement.executeQuery()) {
            result.next();

            try {
                result.getBigDecimal(1).longValueExact();
            } catch (ArithmeticException e) {
                throw new SQLException("누적 매출 금액이 처리 가능한 범위를 초과합니다.", "22003", e);
            }
        }
    }
}
