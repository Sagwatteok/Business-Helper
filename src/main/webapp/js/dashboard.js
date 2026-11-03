const chartCanvas = document.getElementById("weeklySalesChart");

if (chartCanvas) {
    const weeklySalesChart = new Chart(chartCanvas, {
        type: "line",

        data: {
            //차트의 가로축에 표시할 이름
            labels: ["10/28", "10/29", "10/30", "10/31", "11/01", "11/02", "11/03"],

            datasets: [
                {
                    label: "매출",
                    data: [320000, 410000, 385000, 470000, 395000, 432000, 428000],

                    borderColor: "#84B2D0", //그래프 선 색상
                    backgroundColor: "rgba(132, 178, 208, 0.18)", //선 아래에 채워지는 배경색

                    borderWidth: 3, //선 굵기
                    fill: true, //선 아래를 채울지
                    tension: 0.35, //선을 얼마나 부드럽게 할지

                    pointBackgroundColor: "#84B2D0", //	그래프 점 내부 색상
                    pointBorderColor: "#FFFFFF", //	그래프 점 테두리 색상
                    pointBorderWidth: 2, //	그래프 점 테두리 굵기
                    pointRadius: 4 //그래프 점 크기
                }
            ]
        },

        options: { //차트의 화면 표시 방식 설정
            responsive: true, //화면 크기에 맞춰 차트 크기도 변경
            maintainAspectRatio: false, //기본 가로세로 비율을 유지할지 결정

            plugins: { //범례, 툴팁 같은 추가 기능 설정
                legend: { //차트 범례 설정
                    display: false
                },

                tooltip: { //그래프 점에 마우스를 올렸을 때 나오는 안내창
                    callbacks: {
                        label: function (context) {
                            return "매출 ₩ " + context.raw.toLocaleString(); //숫자에 쉼표를 붙여 보기 좋게 변환
                        }
                    }
                }
            },

            scales: { //가로축과 세로축 설정 묶음
                x: {
                    grid: { //차트 배경의 격자선 설정
                        display: false
                    }
                },

                y: {
                    ticks: { //축에 표시되는 숫자 또는 글자 설정
                        callback: function (value) {
                            return "₩ " + value.toLocaleString();
                        }
                    },

                    grid: {
                        color: "#EAF1F5"
                    }
                }
            }
        }
    });
}