# HeadFirstBash

保存自己学习 Bash 时的笔记和练习内容。

参考资料：

-   [bash-guide](https://github.com/Idnan/bash-guide)
-   [Bash 脚本教程](https://wangdoc.com/bash/index.html)
-   [TLCL](http://linuxcommand.org/index.php) 的[中文翻译版](https://billie66.github.io/TLCL/index.html)
-   [Bash Reference Manual](https://www.gnu.org/savannah-checkouts/gnu/bash/manual/bash.html)

## Bash 脚本入门

### 前置知识

一个 Bash 脚本通常是一系列命令的集合，我们可以用它来执行一些通用的操作，从而节约时间。

#### 结构

Bash 脚本由 Shebang 行和脚本内容组成。相比较其它高级编程语言而言，Bash 的语法虽然显得有点啰嗦，但是考虑到它诞生在上世纪 80 年代末，至今已经有超过 30 年的历史了，所以，它能沿用到现在就已经算是一个工程奇迹了(#ﾟДﾟ)。

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

#### 执行

在执行脚本之前，需要添加执行权限：

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

直接在当前目录输入脚本名称是无法执行成功的，因为终端会将它解释为命令。

#### 符号

##### 分号

用于分割两个命令。

##### 命令的组合符

```bash
Command1 && Command2 # 表示 Command1 运行成功后，继续运行 Command2

Command1 || Command2 # 表示 Command1 运行失败后，运行 Command2
```

#### [模式扩展](https://wangdoc.com/bash/expansion.html)

Shell 会先将命令中的特殊字符扩展，然后再执行命令。比如假如输入 `ls ~/workspace` 后，Shell 首先会将 `~/workspace` 扩展成绝对路径，然后再执行 `ls` 命令。像这样的扩展有以下几种：

- 波浪线扩展
- `?` 字符扩展
- `*` 字符扩展
- 方括号扩展
- 大括号扩展
- 变量扩展
- 子命令扩展
- 算术扩展

### 变量

Bash 中的变量有两种，一种是环境变量，另一种是本地变量。

#### 环境变量

分为系统定义的环境变量，和用户定义的环境变量。当我们每次打开一个 Shell 终端时，Shell 会为我们初始化好所有的系统环境变量，如果是子 Shell 的话还会继承父 Shell 中的环境变量（通过 `export` 导出的环境变量）。

我们可以使用 `env` 命令查看所有环境变量。另外，由于环境变量通常都是常量，所以一般使用大写。

常见的系统环境变量：

```bash
BASHPID # Bash 进程的进程 ID
HOME 		# 用户的主目录
HOST 		# 当前主机的名称
IFS 		# 词与词之间的分隔符，默认为空格
LOGNAME # 当前登录用户的用户名
PATH 		# 可执行命令的目录
RANDOM 	# 随机数
SHELL   # 当前 Shell 的名字，比如 bash/zsh/fish 等
TERM    # 终端类型名，即终端仿真器所用的协议
UID     # 当前登录用户的 ID
USER    # 当前用户的用户名
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
${var:=ops} # 如果 var 值存在且不为空返回 var，否则将 var 值设为 ops 并且返回 ops
${var:+ops} # 如果 var 值存在且不为空返回 ops，否则返回 null
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

### 数组

### 条件判断

### 循环

### 函数