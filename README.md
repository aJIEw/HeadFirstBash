# HeadFirstBash

记录下自己学习 Bash 时的笔记和练习内容。

参考资料：

-   [bash-guide](https://github.com/Idnan/bash-guide)
-   [Bash 脚本教程](https://wangdoc.com/bash/index.html)
-   [TLCL](http://linuxcommand.org/index.php) 的[中文翻译版](https://billie66.github.io/TLCL/index.html)
-   [Advanced Bash-Scripting Guide](https://tldp.org/LDP/abs/html/index.html)
-   [Bash Reference Manual](https://www.gnu.org/savannah-checkouts/gnu/bash/manual/bash.html)

## 基础

### 前置知识

一个 Bash 脚本是一系列命令的集合，我们可以把一些重复的操作放到 Bash 脚本中执行，从而节省时间。

#### 术语

- Shell: 通常指 [Unix shell](https://en.wikipedia.org/wiki/Unix_shell)，一种命令行解释器。
- [Bash](https://en.wikipedia.org/wiki/Bash_(Unix_shell)): 用于替代 [sh](https://en.wikipedia.org/wiki/Bourne_shell) 的最为广泛使用的 shell。
- Bash 脚本：一种运行在 Bash 之上的脚本语言，主要用于系统管理、文件操作、运行环境配置等。

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

相比较其它高级编程语言而言，[Bash](https://en.wikipedia.org/wiki/Bash_(Unix_shell)) 的语法虽然显得有点啰嗦，但是考虑到它诞生在上世纪 80 年代末（[sh](https://en.wikipedia.org/wiki/Bourne_shell) 更早，诞生于上世纪 70 年代末），至今已经有超过 30 年的历史了，所以，它能沿用到现在已经算是一个工程奇迹了 (#ﾟДﾟ)。

#### 执行

在执行脚本之前，需要先添加执行权限：

```bash
chmod +x *.sh
```

运行脚本需要使用全路径或者相对路径：

```bash
/path/to/script.sh
# or
./script.sh
# or
bash script.sh
```

直接在当前目录输入脚本名称是无法执行成功的，因为终端会将它当做命令去执行：

```bash
script.sh # "bash: arguments.sh: command not found"
```

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

Shell 会先将命令中的特殊字符扩展，然后再执行命令。比如输入 `ls ~/workspace` 后，shell 首先会将 `~/workspace` 扩展成绝对路径，然后再执行 `ls` 命令。像这样的扩展主要有以下几种：

- 用户目录扩展 `~`
- 单个字符扩展 `?`
- 任意字符扩展 `*`
- 方括号扩展 `[]`
- 大括号扩展 `{}`
- 变量扩展 `$`
- 子命令扩展 `$()`
- 算术扩展 `(())`

##### 子命令扩展

子命令扩展用于将命令的结果作为返回值：

```bash
echo $(date)
```

另外还有一种弃用的写法：

```bash
echo `date`
```

#####  算术扩展

算术扩展用于数字的算术运算：

```bash
echo $((2+2))
```

同样有一种弃用的写法，不过不推荐使用：

```bash
echo $[2+2]
```

算术扩展支持的运算符有：

- \+
- \-
- \*
- /
- %
- \*\* (指数)
- ++
- \-\-

数字默认使用十进制，但是 Bash 也支持其它进制：

- `0`+数字：八进制数字
- `0x`+数字：十六进制数字
- `base#`+数字：base 进制数字

算术扩展也支持位运算：

- <<: 左移运算
- \>\>: 右移运算 
- &: 位的「与」运算
- |: 位的「或」运算
- ~: 位的「否」运算
- ^: 位的「异或」运算

另外，算术扩展除了支持普通的逻辑运算（`>` `<` `==` `&&` `||` `!`）之外，还支持三元条件运算符：

```bash
# 语法
$((expr1 ? expr2 : expr3))

# 例子
((result=2*3))
echo result: $((result > 1? ++result: --result)) 
```

由于 Bash 中所有变量都是字符串，所以，如果想要接受算术运算的结果，可以使用 `let` 关键字：

```bash
let result=2+5
echo variable value: $result
```

除此之外，如果只是想要获得算术运算的结果，还可以使用 `expr` 命令：

```bash
expr 2 + 2
```

不过，数字和运算符之间必须包含至少一个空格，而且特殊字符（如 `*` 等）需要使用 `\` 转义。

其它模式的具体用法见：[Shell-Expansions](https://www.gnu.org/savannah-checkouts/gnu/bash/manual/bash.html#Shell-Expansions)

### 变量

Bash 中的变量有两种，一种是环境变量，另一种是本地变量。

#### 环境变量

分为系统定义的环境变量和用户定义的环境变量。当我们每次打开一个 shell 终端时，shell 会为我们初始化好所有的系统环境变量，如果是子 shell 的话还会继承父 shell 中的环境变量（通过 `export` 导出的环境变量）。

我们可以使用 `env` 命令查看所有环境变量。另外，由于环境变量通常都是常量，所以一般使用大写。

常见的系统环境变量：

```bash
BASHPID  # Bash 进程的 ID
HISTSIZE # 保存历史命令的条数
HOME     # 用户的主目录
HOST     # 当前主机的名称
IFS      # 词与词之间的分隔符，默认为空格+Tab+换行符
LANG     # 系统语言
LINENO   # 当前 shell 中已输入命令的条数
LOGNAME  # 当前登录用户的用户名
MACHTYPE # 机器类型，使用何种架构，x86/x86_64 等
PATH     # 可执行命令的目录
PWD      # 当前目录
RANDOM   # 生成一个随机数
SECONDS  # 当前 shell 从登入后到目前的秒数
SHELL    # 当前 shell 的名字，比如 bash/zsh/fish 等
TERM     # 终端类型名，即终端仿真器所用的协议
UID      # 当前登录用户的 ID
USER     # 当前用户的用户名
```

#### 局部变量

局部变量是用户在当前 shell 中定义的变量，我们在脚本中定义的变量也属于局部变量。我们可以使用 `set` 查看当前 shell 下所有的环境变量和局部变量。

局部变量和环境变量的例子：

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

在使用变量时，存在一种根据变量是否为空动态返回值的语法：

```bash
${var:-ops} # 如果 var 值存在且不为空返回 var，否则返回 ops
${var:+ops} # 如果 var 值存在且不为空返回 ops，否则返回 null (empty string)
${var:=ops} # 如果 var 值存在且不为空返回 var，否则将 var 值设为 ops 并且返回 ops
${var:?ops} # 如果 var 值存在且不为空返回 var，否则打印 "var: ops" 并且退出 (exit 1, stderr)
```

#### Tips

- 变量区分大小写
- Shell 中存在一些特殊变量：
  - `$?` 表示上一个命令的退出码（通过 `exit` 命令）。通常 0 表示执行成功，1 表示执行失败，未指定时默认为 0。
  - `$$` 表示当前 shell 所在进程的 ID。
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

##### 头部匹配 \# #

从字符串头部开始匹配，如果匹配成功，删除匹配成功的部分并返回剩余的部分。

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
echo first item: $array # array will return the first one by default
echo second item: ${array[1]}
echo array: ${array[@]} # or use ${array[*]} to get all items
```

使用 `*` 的时候会使用 `IFS` 中的第一个字符作为数组的分割符。

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

#### if 判断

Bash 中的 if 判断写法如下：

```bash
if condition 1; then
    echo "condition 1"
elif condition 2; then
    echo "condition 2"
else
    echo "others"
fi
```

#### case 判断

case 判断主要用于单个值有多个分支情况的判断，这种情况下相比使用 if 写法更加清晰。

```bash
case expression in
    pattern )
        commands ;;
    pattern )
        commands ;;
    ...
esac
```

case 中的表达式多为字符串，pattern 多为字符串的匹配模式，除了一般的通配符之外，还可以使用字符类等来匹配。另外，Bash 4.0 之后还可以使用 `;;&` 来匹配多个条件。

#### 判断条件

判断条件可以是普通的命令，如果命令返回值为 0 表示条件成立，否则不成立。

```bash
if cd folder; then
    echo "File exists"
fi
```

另外，判断条件也可以是是 test 命令，它有以下几种写法：

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

#### 判断条件类型

##### 文件判断

```bash
if [ -d practice ] && cd practice; then
    echo "Entered folder: practice"
fi
```

##### 字符串判断

```bash
if [ $s1 = $s2 ]; then
    echo "s1 = s2"
fi
```

##### 整数判断

```bash
if [ $i1 -eq $i2 ]; then
    echo "i1 equals i2"
fi
```

##### 算术运算

```bash
if (( $s1 > $s2 )); then
    echo "s1 longer"
else
    echo "s2 longer"
fi
```

##### 正则判断

```bash
# 语法
[[ string =~ regex ]]

# 例子
num=1
if [[ "$num" =~ ^-?[0-9]+$ ]]; then
    echo "$num is an integer."
fi
```

### 循环

#### while

当符合判断条件时执行命令。

```bash
while condition; do
    commands
done
```

#### until

直到符合判断条件时，才退出执行命令。

```bash
until condition; do
    commands
done
```

#### for

```bash
for (( expression1; expression2; expression3 )); do
  commands
done
```

#### for..in

```bash
for variable in list; do
    commands
done
```

#### select

select 循环是一个默认不断执行的循环，主要用于生成菜单项。

```bash
select item in list; do
    commands
done
```

#### 循环跳出和中断

Bash 中同样可以使用 `continue` 跳出循环以及 `break`  中断循环。


### 函数

Bash 中可以使用别名（alias）封装单个命令，如果是复杂的命令则可以使用函数。

完整的函数形式如下：

```bash
function functionName() {
    echo "Hello"
}
```

但实际中也可以使用省略的写法：

```bash
# omit parenthesis
function greeting {
    echo "Hi"
}

# omit keyword function
foo() {
    echo "bar"
}
```

我们可以使用 `unset -f` 删除一个函数：

```bash
unset -f functionName
```

查看所有已定义的函数：

```bash
declare -f [functionName]
```

#### 函数形参

Bash 中的函数的形参没有参数名，我们可以按照传入参数的顺序来访问每个参数，比如访问从第 1 到第 9 个参数使用 `$1` - `$9`，第 10 个之后的参数使用 `${n}` 的形式。

- `$0`: 函数所在的脚本的文件名
- `$#`: 参数总数
- `$@`: 全部参数，使用空格分割
- `$*`: 全部参数，使用 `$IFS` 中的第一个字符作为分割符

#### 局部变量

Bash 脚本中声明的变量，无论是否在函数体内，都会被当做全局变量，如果想要声明函数体内的局部变量，需要使用 `local` 关键字：

```bash
function intro() {
    local age=$((`date +%Y` - $birth_year))
    echo "Hi, my name is $1, and I'm $age years old."
}
```

#### 函数返回

Bash 中使用 `return` 给函数指定返回值，也可以用于退出函数。

```bash
add() {
    local regex_num=^-?[0-9]+$
    if [[ $1 =~ $regex_num && $2 =~ $regex_num ]]; then
        return $(($1+$2))
    fi
}
```

#### 执行顺序

Bash 中函数的执行优先级高于脚本，但是低于别名。也就是说，如果函数名、脚本名、别名相同，执行顺序是：别名>函数名>脚本名。

### 脚本参数

Bash 脚本的参数和函数的参数类似，也是通过 `$1` \~ `$n` 的形式来访问。

#### 改变脚本参数

##### `shift`

通过 `shift` 命令可以移除脚本的首个参数，并且使之后的参数都前移一位：

```bash
# 依次读取并移除参数
while [[ -n $1 ]]; do
    echo "there're $# arguments left, the first one is $1"
    shift
done
```

#### 参数解析

##### `getopts`

通过该命令解析命令行参数的配置选项，比如 `ls -al` 中的 `-al`。

```bash
# 使用方式
getopts OPTSTRING VARNAME [ARGS...]
```

其中 `OPTSTRING` 表示当前命令所有可接收的配置选项，其中：

- 单个字符，表示可选项无参数
- 单个字符+`:`，表示可选项携带参数。

例子：

- `abc` 表示可选项为 `-a` 或 `-b` 或 `-c`，如果是其它字符会报错。
- `abc:` 表示可选项为 `-a` 或 `-b` 或 `-c+参数`，如果是其它字符或者 `-c` 缺少参数都会报错。
- `:ab:c:` 表示可选项为 `-a` 或 `-b 参数` 或 `-c 参数`，开头添加了 `:`，所以即使是不支持的选项也不会报错。

另外，还可以配合以下环境变量使用：

- `OPTARG`: 表示选项的参数。
- `OPTIND`: 表示已处理的参数数量，默认为 1。

#### 配置选项终止符

`-` 和 `--` 开头的参数会被当做配置选项，所以，使用这两个字符开头的实参就需要使用配置选项终止符 `--`。

```bash
cat -- -f.sh | grep -- "--hello"
```

上面的例子中，文件名以 `-` 开头，所以需要使用配置选项终止符 `--`；搜索文件中的 `--` 开头的文字，同样需要在参数前添加 `--`。否则，`cat` 命令将会无法识别 `-f` 选项，`grep` 命令也会无法识别 `--hello` 选项。

## 进阶

### Debug

#### 启动环境

每次启动一个 shell，都会开启一个新的 session，一个 session 代表当前 shell 的运行环境。Session 可以分为 login shell 和 non-login shell。

##### login shell

顾名思义，就是需要用户登录的 shell session，启动时会从 `/etc/profile` 和 `~/.bash_profile` 中读取环境变量。注意，`~/.bash_profile` 也会触发读取 `~/.bashrc` 和 `/etc/bashrc`。

##### non-login shell

通常是被 login shell 启动的 shell，比如在当前 shell 中输入 `bash` 命令后，会启动一个新的 shell，此时就是一个 non-login shell，它会重新读取 `~/.bashrc` 和 `/etc/bashrc` 中的环境变量。

non-login shell 还有一种特殊的情况，那就是非交互的 (non-interactive)，最常见的是运行一个脚本的时候，所有的脚本都在单独启动的一个子 shell 中执行，并且在执行完毕后就立即退出该 shell。

##### 查看 shell 类型

输入下面的命令，如果返回值前带 `-` 说明是 login shell，否则就是 non-login shell。

```bash
echo $0
```

#### 环境变量

##### `BASH_SOURCE`

返回一个字符串数组，包含脚本的调用堆栈（脚本名，最先被调用的在前）：

```bash
function f() {
    echo BASH_SCRIPT[0]: ${BASH_SOURCE[0]} # 方法 f 所在的脚本名
    echo BASH_SCRIPT[1]: ${BASH_SOURCE[1]} # 调用方法 f 所在的脚本名
    echo BASH_SCRIPT[2]: ${BASH_SOURCE[2]} # 以此类推
}
```

##### `FUNCNAME`

返回一个字符串数组，包含方法的调用堆栈（方法名，最先被调用的在前）：

```bash
function f() {
    echo funcname0: ${FUNCNAME[0]} # f 的方法名
    echo funcname1: ${FUNCNAME[1]} # 调用方法 f 的方法名
    echo funcname2: ${FUNCNAME[2]} # 以此类推
}
```

##### `BASH_LINENO`

返回一个字符串数组，包含方法调用的行号（最先被调用的方法在前）：

```bash
function f() {
    echo "method call at: ${BASH_LINENO}"
}
f
```

##### `LINENO`

返回脚本所在的行号：

```bash
echo "this line is at: $LINENO"
```

#### Set 命令

Bash 脚本是在一个子 shell 中执行的，我们可以使用 `set` 命令调整 shell 运行环境的参数。

##### `set -x`

用于输出命令：

```bash
set -x

echo "Hi"

# 输出：
+ echo "Hi"
Hi
```

##### `set -u`

遇到未设置的变量将报错，而不是默认的当做空值：

```bash
set -u

echo $A # A: unbound variable
```

##### `set -e`

脚本出错时，停止执行。

```bash
set -e

foo
echo bar

# 输出 `foo: command not found` 并退出，不再执行之后的命令
```

##### `set -o pipefail`

当错误命令遇到管道命令时，管道命令总是会执行成功，所以我们可以使用该参数使得只要有一个子命令执行失败，整个管道命令也失败。

##### `set -E`

`-e` 参数会导致函数内的错误不会被 `trap` 捕获，所以可以使用 `-E` 纠正这一行为。

##### `set -n`

不运行命令，只检查语法是否正确。

##### `set -f`

不对通配符进行扩展。

##### `set -v`

打印 shell 脚本中的每一行输入（包括空白行）。

##### `set -o noclobber`

防止重定向运算符 `>` 覆盖已经存在的文件。

##### 总结

一般在调试脚本时，可以开启以下参数：

```bash
set -Eeux
set -o pipefail
set -o noclobber
```

另外，也可以在启动脚本时指定对应的参数，比如：

```bash
# 不运行脚本，只检查是否有语法错误
bash -n script.sh
```

### 常用命令

收集一些常见命令的用法。

#### 文件相关

##### `mktemp`

用于创建一个只有创建者可读写的临时文件，从而保证安全性。

```bash
TEMPFILE=$(mktemp)

echo $TEMPFILE
```

#### 其它命令

##### `trap`

用于响应系统信号。注意，如果你的命令行环境是 zsh，直接运行 `trap` 命令可能会无响应。

查看所有系统信号：

```bash
trap -l
```

在捕捉到系统信号后触发命令：

```bash
trap 'echo "Caught signal EXIT"' EXIT
```

