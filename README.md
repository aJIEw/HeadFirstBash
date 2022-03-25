# HeadFirstBash

记录下自己学习 Bash 时的笔记和练习内容。

参考资料：

-   [bash-guide](https://github.com/Idnan/bash-guide)
-   [Bash 脚本教程](https://wangdoc.com/bash/index.html)
-   [TLCL](http://linuxcommand.org/index.php) 的[中文翻译版](https://billie66.github.io/TLCL/index.html)
-   [Bash Reference Manual](https://www.gnu.org/savannah-checkouts/gnu/bash/manual/bash.html)

## Bash 脚本入门

### 前置知识

一个 Bash 脚本通常是一系列命令的集合，我们可以用它来执行一些通用的操作，从而节约时间。

#### 结构

Bash 脚本由 Shebang 行和脚本内容组成。

```bash
# 通过 Shebang 行指定脚本的解释器是 bash
#!/usr/bin/env bash

# 变量
user=$LOGNAME

# 方法
function sayHi() {
  echo "Hello, $user!"
}

# 条件判断
if [ -n $user ]; then
	sayHi
fi
```

相比较其它高级编程语言而言，[Bash](https://en.wikipedia.org/wiki/Bash_(Unix_shell)) 的语法虽然显得有点啰嗦，但是考虑到它诞生在上世纪 80 年代末（[sh](https://en.wikipedia.org/wiki/Bourne_shell) 更早，诞生于 70 年代末），至今已经有超过 30 年的历史了，所以，它能沿用到现在就已经算是一个工程奇迹了(#ﾟДﾟ)。

#### 执行

在执行脚本之前，需要先添加执行权限：

```bash
chmod +x script.sh
```

运行脚本需要使用全路径或者相对路径：

```bash
/path/to/script.sh
# or
./script.sh
# or
bash script.sh

script.sh # "bash: arguments.sh: command not found"
```

直接在当前目录输入脚本名称是无法执行成功的，因为终端会将它理解为命令去执行。

#### 符号

##### 分号

用于分割两个命令。

```bash
command1 ; command2
```

##### 命令的组合符

```bash
Command1 && Command2 # 表示 Command1 运行成功后，继续运行 Command2

Command1 || Command2 # 表示 Command1 运行失败后，运行 Command2
```

#### [模式扩展](https://wangdoc.com/bash/expansion.html)

Shell 会先将命令中的特殊字符扩展，然后再执行命令。比如假如输入 `ls ~/workspace` 后，Shell 首先会将 `~/workspace` 扩展成绝对路径，然后再执行 `ls` 命令。像这样的扩展主要有以下几种：

- `~` 用户目录扩展
- `?` 单个字符扩展
- `*` 任意字符扩展
- 方括号扩展 `[]`
- 大括号扩展 `{}`
- 变量扩展 `$`
- 子命令扩展 `()`
- 算术扩展 `(())`

更具体的介绍见：[Shell-Expansions](https://www.gnu.org/savannah-checkouts/gnu/bash/manual/bash.html#Shell-Expansions)

### 变量

Bash 中的变量有两种，一种是环境变量，另一种是本地变量。

#### 环境变量

分为系统定义的环境变量和用户定义的环境变量。当我们每次打开一个 Shell 终端时，Shell 会为我们初始化好所有的系统环境变量，如果是子 Shell 的话还会继承父 Shell 中的环境变量（通过 `export` 导出的环境变量）。

我们可以使用 `env` 命令查看所有环境变量。另外，由于环境变量通常都是常量，所以一般使用大写。

常见的系统环境变量：

```bash
BASHPID  # Bash 进程的进程 ID
HISTSIZE # 保存历史命令的条数
HOME 	   # 用户的主目录
HOST     # 当前主机的名称
IFS      # 词与词之间的分隔符，默认为空格
LANG     # 系统语言
LINENO   # 输入命令的条数
LOGNAME  # 当前登录用户的用户名
MACHTYPE # 机器类型，使用何种架构，x86/x86_64 等
PATH     # 可执行命令的目录
PWD      # 当前工作目录
RANDOM   # 随机数
SECONDS  # 当前 Shell 从登入后到目前的秒数
SHELL    # 当前 Shell 的名字，比如 bash/zsh/fish 等
TERM     # 终端类型名，即终端仿真器所用的协议
UID      # 当前登录用户的 ID
USER     # 当前用户的用户名
```

#### 局部变量

局部变量是用户在当前 Shell 中定义的变量，我们在脚本中定义的变量也属于局部变量。我们可以使用 `set` 查看当前 Shell 下所有的环境变量和局部变量。

```bash
!/usr/bin/env bash

# local variables
str="123"
NUM=456
echo $str
echo ${str}$NUM

# environment variables
export SOME_VARIABLE="cool_variable"
```

##### 变量默认值

在使用局部变量时，存在一种类似于三目运算符的为变量赋值的方法，语法如下：

```bash
${var:-ops} # 如果 var 值存在且不为空返回 var，否则返回 ops
${var:+ops} # 如果 var 值存在且不为空返回 ops，否则返回 null
${var:=ops} # 如果 var 值存在且不为空返回 var，否则将 var 值设为 ops 并且返回 ops
${var:?ops} # 如果 var 值存在且不为空返回 var，否则打印 "var: ops" 并且退出（错误码为 1）
```

#### Tips

- 变量区分大小写
- Shell 中存在一些特殊变量：
  - `$?` 表示上一个命令的退出码（通过 `exit` 命令）。通常 0 表示执行成功，1 表示执行失败，未指定时默认为 0。
  - `$$` 表示当前 Shell 所在进程的 ID。
  - `$_` 表示上个命令的最后一个参数。
  - `$@` 表示命令所有参数值。
  - `$#` 表示上个命令的参数数量。

### 字符串

Bash 中所有变量都是字符串。

#### 获取长度

使用 `${#var}` 获取字符串长度

```bash
str=Love
echo $str\'s length is ${#str}
```

#### 字符串截取

使用 `${var:index:length}` 对字符串进行截取，如果长度未指定，则默认截取到字符串末尾。

```bash
str="Love and Peace"
echo ${str:0:4} #Love
echo ${str:9} #Peace
```

#### 字符串匹配和替换

##### 头部匹配 #

从字符串开头开始匹配，如果匹配成功，删除匹配的部分并返回剩余的部分。

有两种替换模式，最短替换和最长替换，分别表示为 `${path#pattern}` 和 `${path##pattern}`。

```bash
path=/home/root/workspace/dg.ajiew.me
echo original path: $path
echo after remove head dir: ${path#/*/}
echo after remove parent dirs: ${path##*/}
```

##### 尾部匹配 %

和头部替换相似，只不过是从字符串尾部开始匹配，同样分为最短替换和最长替换。

```bash
echo the parent dir: ${path%/*} 
echo after remove end: ${path%%.*} 
```

##### 全局匹配 /

这个应该是最常用的替换模式，用于匹配任意位置的字符串，可以匹配一次或者所有符合条件的字符。

```bash
echo another way to remove parent dirs: ${path/#\/*\//}
echo remove all dots: ${path//./} 
```

注意，在使用全局匹配的时候，如果匹配内容包含 `/` 等特殊字符，需要使用 `\` 转义。

##### 字符串替换

在字符串匹配的基础上，我们可以用目标字符替换匹配到的字符，语法如下：

```bash
${var/#old/new} # 头部匹配并替换
${var/%old/new} # 尾部匹配并替换
${var/old/new}  # 全局匹配并替换
${var//old/new} # 全局匹配并替换所有
```

例子：

```bash
echo new dir name: ${path/#\/*\//\/etc/}
echo replace all dots with slashes: ${path//.//}
```

#### Tips

- 使用 `${var^^}` 将字符串转换为大写，使用 `${varname,,}` 将字符串转换为小写。

### 数组

Bash 中的数组没有长度限制，和绝大部分编程语言一样，数组的下标是从 0 开始的。

创建数组的方法主要有两种，一种是通过下标来逐个定义数组中的元素：

```bash
array[0]="this"
array[1]="is"
array[2]="array"
```

更常见的方法是通过圆括号来定义：

```bash
array=("this" "is" "array")
```

也可以在圆括号中指定元素的下标：

```bash
array=([1]="is" [0]="this" [2]="array")
```

#### 获取数组长度

```bash
echo array length is ${#array[@]}
echo another way of showing length ${#array[*]}
```

注意 `@` 和 `*` 所表达的含义是一致的，下面的例子中也是一样。

#### 获取数组下标

```bash
echo "${!array[@]}" # or ${!array[*]}
```

#### 获取数组元素

```bash
echo array: ${array[@]} # or ${array[*]}
```

#### 数组截取

和字符串截取类似，数组的截取也是通过下标+长度的方式：

```bash
echo the first two elements: ${array[@]:0:2}
echo ${array[@]:6}
```

#### 数组修改

```bash
# 新增元素
array+=(new element)

# 删除元素
unset array[0]
```

### 条件判断

Bash 中的条件判断写法如下：

```bash
if condition 1; then
	echo "condition 1"
elif condition 2; then
	echo "condition 2"
else
	echo "others"
fi
```

#### 判断条件

判断条件可以是普通的命令，如果命令返回值为 0 表示条件成立，否则不成立。另外，判断条件也可以是是 test 命令，它有以下几种写法：

```bash
test condition
[ condition ]
[[ condition ]]
```

前面两种没有区别，第三种也很常见，使用它的好处是可以省略双引号。

```bash
# 变量名中包含空格，如果在条件中不加引号，会被扩展成 -a $PWD/test file.sh 造成条件判断不成立
file="test file.sh"
if [ -a $PWD/$file ]; then # binary operator expected
    echo file exists
else
	echo file not found
fi
```

解决方法有两个，要么添加双引号：

```bash
if [ -a "$PWD/$file" ]; then
```

或者使用双中括号：

```bash
if [[ -a $PWD/$file ]]; then
```

判断条件还可以是算术运算：

```bash
if (( $s1 > $s2 )); then
	echo "s1 longer"
else
	echo "s2 longer"
fi
```

### 循环

### 函数