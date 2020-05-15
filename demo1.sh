#!/bin/bash

world="word"
echo "hello ${world}!" #打印输出语句

read name
echo "hello ${name}" #读取输入内容

echo dirs #显示当前存储目录的列表

#./demo1.sh
#/bin/bash demo1.sh
#bash demo1.sh

$$ #获取当前进程的 PID

content=$(cat test.txt) #将命令的结果赋值给变量
#content=`cat test.txt`
echo ${content}

readonly readonlyPara #只读变量

unset name #删除变量

###############################################命令替换
begin_time=`date`
sleep 1s
end_time=$(date)
echo "begin_time:${begin_time}"
echo "end_time:${end_time}"

begin_time=`date +%s`
sleep 1s
end_time=$(date +%s)
run_time=$((end_time - begin_time)) #(( ))是 Shell 数学计算命令
echo "run_time:${run_time}"

###############################################函数
function foo() {
    return $(($1 + $2)) #$n（n≥1）	传递给脚本或函数的参数
}
foo 1 2
echo $? #上个命令的退出状态，或函数的返回值，
echo $# #传递给脚本或函数的参数个数。
echo $* #传递给脚本或函数的所有参数。

###############################################字符串
name="kyle"
age=18
url="https://www.google.com/"
echo ${#name} #获取字符串长度
echo "name:${name},age:${age}" #字符串拼接
echo ${url:8:14} #截取字符串，start 是起始位置（从左边开始，从 0 开始计数），length 是要截取的长度（省略的话表示直到字符串的末尾）。
echo ${url:0-15:14} #截取字符串，从字符串的右边开始计数，下表从右向左数(1开始计数)
echo ${url#*/} #截取子串，#号可以截取指定字符（或者子字符串）右边的所有字符，*是通配符的一种，忽略左边的所有字符，直到遇见*后面的字符
echo ${url#https} #截取子串，如果不需要忽略 * 左边的字符，那么也可以不写*
echo ${url##*.} #最后一个指定字符（子字符串）再匹配

###############################################数组
students=(kyle nick lewis 666)
echo ${students[4]}
echo ${students[*]} #获取所有元素，其实将数组扩展成列表
echo ${#students[*]} #获取数组长度
students[3]=888
kyle=${students[3]} #重新赋值给变量

class=(1 2 3)
stuClass=(${students[*]} ${class[*]}) #合并数组
echo ${stuClass[*]}

delArray=(1 2 3)
unset delArray[0] #删除数组元素

###############################################内建命令
type unset #检查unset命令是否是内建命令
exit #强制 shell 以指定的退出状态码退出
history #显示命令历史记录
pwd #显示当前工作目录的路径名

echo -n "hello," #输出不换行
echo "kyle"
echo -e "hello \nkyle" #-e参数来让 echo 命令解析转义字符


read -s -t 30 -p "Enter password in 20 seconds(once):" pwd1 #t:设置超时时，p:显示提示信息，s:静默模式（Silent mode），不会在屏幕上显示输入的字符。
printf "\n" #语句用来达到换行的效果，否则 echo 的输出结果会和用户输入的内容位于同一行，不容易区分。
read -s -t 30 -p "Enter password in 20 seconds(again):" pwd2
printf "\n"
if [ pwd1 == pwd2 ]; then
  echo "Valid password"
else
  echo "Invalid password"
fi



###############################################alias别名
alias timestamp='date +%s'
echo $(timestamp)
unalias timestamp #删除别名

###############################################if 语句
read n
read i
if (( ${n} = ${i} ))); then
    echo "值相同"
fi

read -p "输入年龄：" age
if (( ${age} <= 2 ))); then
    echo "婴儿"
elif (( ${age} >=3 && ${age} <=10 ))); then
    echo "儿童"
else
  echo "老人家"
fi

###############################################test命令（Shell []）
#test 是 Shell 内置命令，用来检测某个条件是否成立。test 通常和 if 语句一起使用，并且大部分 if 语句都依赖 test。
#test 命令也可以简写为[]
#test -e 1.txt 判断文件是否存在。
#test -e 1 判断文件是否存在，并且是否为目录文件。

#-r filename	判断文件是否存在，并且是否拥有读权限。
#-w filename	判断文件是否存在，并且是否拥有写权限。
#-x filename	判断文件是否存在，并且是否拥有执行权限。
#-u filename	判断文件是否存在，并且是否拥有 SUID 权限。

#num1 -eq num2	判断 num1 是否和 num2 相等。
#num1 -ne num2	判断 num1 是否和 num2 不相等。
#num1 -gt num2	判断 num1 是否大于 num2 。
#num1 -lt num2	判断 num1 是否小于 num2。
#num1 -ge num2	判断 num1 是否大于等于 num2。
#num1 -le num2	判断 num1 是否小于等于 num2。

read -p "输入年龄：" age
if test ${age} -lt 2; then
    echo "婴儿"
elif [ ${age} -gt 3 ] && [ ${age} -lt 10 ]; then
    echo "儿童"
else
    echo "老人家"
fi

read tel
if [[ $tel =~ ^1[0-9]{10}$ ]]
then
    echo "你输入的是手机号码"
else
    echo "你输入的不是手机号码"
fi


###############################################case in
read -p "输入年龄：" age
case $age in
1)
 echo "1岁"
  ;;
2)
  echo "2岁"
  ;;
3)
  echo "3岁"
  ;;
4)
  echo "4岁"
  ;;
esac


###############################################while
num=1
while ((num <= 100)); do
    echo "${num}"
    (( num+=1 ))
done

num=1
while [ ${num} -lt 100 ]; do
    echo "${num}"
    (( num+=1 ))
done

###############################################for
n=100
for (( i = 0; i < n; i++ )); do #exp1; exp2; exp3：初始化语句; 判断条件; 自增或自减
  if(( i > 10 )); then
      break  #强制退出
  fi
  echo "${i}"
done

n=100
for (( ; i < n; i++ )); do #省略 初始化语句
  if(( i > 10 )); then
      break  #强制退出
  fi
  echo "${i}"
done

for i in {1..10} ; do
    echo "${i}"
done


###############################################function
function getName() {
    echo "hello word!"
}
getName

function getNames() {
    echo "hello $1,$2,$3"
}
getNames kyle nick lewis


