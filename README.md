<h3 align="center">A fast and incredible Emacs config</h3>

<p align="center">
  <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/0/08/EmacsIcon.svg/120px-EmacsIcon.svg.png" />
</p>

<div align="center">

[![Build Status](https://github.com/condy0919/.emacs.d/workflows/CI/badge.svg)](https://github.com/condy0919/.emacs.d/actions)
[![License](http://img.shields.io/:license-gpl3-blue.svg)](LICENSE)
![Supports Emacs 26-28.x](https://img.shields.io/badge/Supports-Emacs_26.3_--_28.x-blueviolet.svg?style=flat-square&logo=GNU%20Emacs&logoColor=white)

</div>

个人**Emacs**配置
====

仿 [Centaur Emacs](https://github.com/seagle0128/.emacs.d) 的个人配置.

```bash
git clone --depth 1 https://github.com/condy0919/.emacs.d ~/.emacs.d
```

仅包含**C/C++/Rust/OCaml/Haskell**相关配置，且全线使用`lsp`。当前由于
`ocaml-lsp`十分难用，`haskell-ide-engine`水土不服，故这2个语言没有采用`lsp`。

保持着尽量使用`Emacs`自带功能的原则，能用自带的就用自带的。

# 需要的依赖

- `hunspell` 拼写检查，目前仅在`git-commit-mode`下启用
- `languagetool` 更好的拼写检查、语法纠错工具
- `rg` 更快的`grep`
- `cmake` 编译`vterm`的模块、`c++`项目的构建工具
- `git` 这个就不用说了吧？
- `gcc` 这个就不用说了吧？

# 基础配置

最基础的配置包含了那些在所有`mode`下都不会变更的配置，包含了：

| 包名       | 功能                                                 |
|------------|------------------------------------------------------|
| align      | `align-regexp`可以自动对齐选择的符号                 |
| autorevert | 当文本被其他编辑器修改后，可自动更新                 |
| delsel     | 选中文本可以直接覆盖着写，一般编辑器都默认开这个功能 |
| hl-line    | 高亮当前行                                           |
| paren      | 高亮匹配的括号                                       |
| saveplace  | 自动记录上次打开文件的位置                           |
| simple     | 在`modeline`里显示行号、列号以及当前文本的大小     |
| so-long    | 打开长行的文件不再痛苦 (`Emacs` 27+ 自带)            |

而这几个包也是`Emacs`自带的。

为了保持界面的整洁，禁用了菜单栏、工具栏和滚动条。

在跳转之后会闪烁一下当前行，这样就比较容易知道当前光标在哪里了。这个功能也是基于
自带的`pulse`。

# 插件配置、升级

选用`use-package`来管理插件。对于`elpa`, `melpa`里没有的包，使用`straight.el`辅
助下载。`straight.el`在自举过程中会连接`githubusercontent.com`这个域名，此域名在
国内访问几乎不可达，建议`bypass`之。

而自动升级选择了`auto-package-update`。

# 界面

使用了`doom-themes`和`doom-modeline`，简直惊艳！`doom-one`的界面非常好看！

# 趁手的工具

`which-key`, `rg`是比较常用的工具。更有`projectile`管理项目，让项目编译、测试、
运行变得更加方便。而且还有`counsel-projectile`的加成，在原有`projectile`的基础上
又添加了许多`ivy action`，更一步提升了便捷性。

`avy`用来代替`vim-easymotion`。而且`avy`还提供了`goto-line`的功能，这下都不用开
`relative line number`来`8k` `9j`这样跳了。

自然`ivy`,`counsel`是要上的，补全功能太好用了。没有`counsel`加持的`M-x`根本无法
让人按下去。这里没有使用`swiper`是因为它下方占用空间过大(继承于`ivy`的设置)，搜
索时肯定是比较在意上下文，而一个`swiper`就占用了`ivy-height`行就显得有点奢侈。而
自带的`isearch`在稍加设置之后，效果也还可以接受。当`evil-search-module`设置成
`isearch`后，也可以使用相同的快捷键来触发`ivy-occur`。再加上`ivy-occur`可以与
`wgrep`配合，将原来的「搜索、打开对应文件、修改」变成了「搜索、修改」。

`vterm`作为一个与原生终端更加接近的终端模拟器，单就外观来看已经比`Emacs`自带的
`eshell`好看。再加上`shell-pop`的辅助，美观又实用的`terminal`模拟器就出现了。

`Emacs`下的`markdown-mode`让人惊艳，突然觉得写文档也会这么快乐。与之相辅相成的还
有`separedit`,让人在代码里写`documentation comments`不再烦恼。

从`neovim`迁移过来的我，自然是常开`evil-mode`，相关的`evil`套件有:

- evil-leader
- evil-nerd-commenter
- evil-surround
- evil-magit

# 按键绑定

## evil-mode

`normal`状态下增加了如下键绑定:

| key           | function                                             |
|---------------|------------------------------------------------------|
| <kbd>gs</kbd> | `evil-avy-goto-char-timer` 来跳转到目标字符          |
| <kbd>go</kbd> | `evil-avy-goto-word-or-subword-1` 来跳转至目标单词处 |
| <kbd>gl</kbd> | `evil-avy-goto-line` 来跳转到对应行                  |

`avy`真乃神器也！

## Emacs

| key                | function                                                                      |
|--------------------|-------------------------------------------------------------------------------|
| <kbd>M-;</kbd>     | `evilnc-comment-or-uncomment-lines` 注释与反注释                              |
| <kbd>C-c '</kbd>   | 通过`separedit`在注释中快乐地写代码                                           |
| <kbd>C-c x</kbd>   | 调用`quickrun`来运行当前`buffer`内的代码。`eval`快人一步！                    |
| <kbd>M-=</kbd>     | 在下方弹出一个`vterm`终端                                                     |
| <kbd>C-c p</kbd>   | `projectile`调用前缀，方便地在项目内跳转、编译等其他功能                      |
| <kbd>C-c t o</kbd> | `hl-todo-occur`查找当前`buffer`内的**TODO**/**FIXME**等关键字                 |
| <kbd>C-c t p</kbd> | 上一个高亮的关键字                                                            |
| <kbd>C-c t n</kbd> | 下一个高亮的关键字                                                            |
| <kbd>C-x g</kbd>   | 呼出 `magit`                                                                  |
| <kbd>C-M-;</kbd>   | 在`git-commit`时会有`flyspell`检查单词是否错误，通过此按键自动修正            |
| <kbd>M-o</kbd>     | 原生`C-x o`来切换`window`有点反人类，绑定在单键上就可以快速的切换至其他窗口了 |
| <kbd>C-c [</kbd>   | 调用`align-regexp`提供以一个对齐符号的功能                                    |
| <kbd>C-c i l</kbd> | 方便地插入`SPDX`形式的`license`头部                                           |

更详细的按键绑定请直接看代码. :-)

# 通用开发设置

- 显示行末空白字符
- 高亮**TODO** **FIXME**等关键字
- `dumb-jump`作为`lsp-find-defition`失败后的备份手段
- `magit`作为`git`客户端
- `hideshow`来显示/隐藏结构化的代码块，如 "{ }" 函数体等
- `rmsbolt`作为一个本地的 **Compiler Explorer** 相比于`godbolt`友好一点
- `quickrun`作为一个能够执行部分区域内的代码块，方便快速验证函数功能

# prog-mode

## cc-mode

- clangd `lsp-mode`
- 禁用了`flycheck`，因为`gcc/clang/cppcheck`的`checker`无法正确包含头文件的路径

## rust-mode

- rls `lsp-mode` 默认

## ocaml-mode

- 启用 `merlin` 作为补全后端

## haskell-mode

- 使用 `dante`

# 个性化

- 自己博客文章的查找、新建
- 插入`SPDX`形式的`license`头功能已独立[license.el](https://github.com/condy0919/license.el)
- 将常用的功能键绑定在`leader`键上
