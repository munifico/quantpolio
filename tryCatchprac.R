result = tryCatch({
  실행하고자 하는 코드
}, warning = function(w) {
  경고 발생 시 실행할 구문
}, error = function(e) {
  에러 발생 시 실행할 구문
} finally = {
  오류의 여부와 관계 없이 무조건 수행할 구문, 생략가능
}
  
number = data.frame(1, 2, 3, "4", 5, stringsAsFactors = FALSE)
str(number)

for (i in number){
  print(i^2)
}

for (i in number){
  tryCatch({
    print(i^2)
  }, error = function(e){
    print(paste('Error:', i))
  })
}
