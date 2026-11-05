const requiredSelects = document.querySelectorAll(".mapping-select[required]");
const mappingNextButton = document.getElementById("mappingNextButton");

function checkRequiredMapping() { //필수 열 매핑 항목을 모두 선택했을 때만 버튼 활성화
    let isComplete = true;

    requiredSelects.forEach(function (select) {
        if (select.value === "") {
            isComplete = false;
        }
    });

    mappingNextButton.disabled = !isComplete;
}

requiredSelects.forEach(function (select) {
    select.addEventListener("change", checkRequiredMapping);
});

checkRequiredMapping();