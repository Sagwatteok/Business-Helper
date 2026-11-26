package com.bizmate.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.bizmate.model.Product;
import com.bizmate.util.DbConnection;

public class ProductDao {
    public void insert(Product product) throws SQLException {
        String sql = "INSERT INTO products (product_id, product_name, category, sale_price, estimated_cost, sale_status) VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection connection = DbConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, product.getProductId());
            statement.setString(2, product.getProductName());
            statement.setString(3, product.getCategory());
            statement.setLong(4, product.getSalePrice());
            statement.setLong(5, product.getEstimatedCost());
            statement.setString(6, product.getSaleStatus());
            statement.executeUpdate();
        }
    }

    public List<Product> findAll() throws SQLException {
        String sql = "SELECT product_id, product_name, category, sale_price, estimated_cost, sale_status FROM products ORDER BY product_name, product_id";
        List<Product> products = new ArrayList<>();

        try (Connection connection = DbConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql);
             ResultSet result = statement.executeQuery()) {
            while (result.next()) {
                Product product = new Product(result.getString("product_id"), result.getString("product_name"), result.getString("category"), result.getLong("sale_price"), result.getLong("estimated_cost"), result.getString("sale_status"));
                products.add(product);
            }
        }

        return products;
    }

    public void saveChanges(List<Product> updatedProducts, String[] deletedProductIds) throws SQLException {
        String updateSql = "UPDATE products SET product_name = ?, category = ?, sale_price = ?, estimated_cost = ?, sale_status = ? WHERE product_id = ?";
        String deleteSql = "DELETE FROM products WHERE product_id = ?";

        try (Connection connection = DbConnection.getConnection()) {
            connection.setAutoCommit(false);

            try {
                try (PreparedStatement update = connection.prepareStatement(updateSql);
                     PreparedStatement delete = connection.prepareStatement(deleteSql)) {
                    for (Product product : updatedProducts) {
                        update.setString(1, product.getProductName());
                        update.setString(2, product.getCategory());
                        update.setLong(3, product.getSalePrice());
                        update.setLong(4, product.getEstimatedCost());
                        update.setString(5, product.getSaleStatus());
                        update.setString(6, product.getProductId());

                        if (update.executeUpdate() != 1) {
                            throw new SQLException("수정할 상품이 없습니다.");
                        }
                    }

                    for (String productId : deletedProductIds) {
                        delete.setString(1, productId);

                        if (delete.executeUpdate() != 1) {
                            throw new SQLException("삭제할 상품이 없습니다.");
                        }
                    }
                }

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
}
