#!/bin/bash

#curl 결과를 result 변수에 저장
result=$(docker exec jenkinsconnect curl -s "http://localhost:8090/sum?a=1&b=2")

# 기대값을 설정
expected=3

# 결과값이 기대값과 동일한지 체크
if [ "$result" -eq "$expected" ]; then
    exit 0 #pass
else
    echo "Test failed. expected $expected, but result is $result"
    exit 1
fi