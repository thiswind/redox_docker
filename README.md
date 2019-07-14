# Redox Docker

在redox官方的docker脚本基础上修改而来，以在非GNU环境下面，可以获得一个命令行，可以直接使用GNU的工具链来编译Redox

# 前置条件

## 安装Docker

# 使用方法

## 1. 制作Docker本地镜像

```bash
cd redox_docker
./build
```

## 2. 运行docker容器，获得一个GNU环境

```bash
# 假定你目前在`redox_docker`目录下
cd ..
./redox_docker/docker.sh

```

## 3. 在docker当中下载redox，并执行bootstrap

参考：[https://gitlab.redox-os.org/redox-os/redox#cloning-building-and-running](https://gitlab.redox-os.org/redox-os/redox#cloning-building-and-running)

```bash
curl -sf https://gitlab.redox-os.org/redox-os/redox/raw/master/bootstrap.sh -o bootstrap.sh && bash -e bootstrap.sh

```

bootstrap执行完毕之后,会把redox克隆到`./redox/`目录下。接下来再安装一下编译的依赖：

```bash
cd redox
./bootstrap.sh -d
```

到这里，基本的编译环境就做好了。注意，这个命令是在docker容器里执行的，编译环境是要安装在容器里。

## 4. 编译redox

```bash
cd redox
make all
```

这一步最好给电脑插上电源，因为很可能会需要好几个小时。如果你的网络不稳定，你可能需要重复来很多次。如果中途断网中断了，你只需要重新执行`make all`即可

## 4. 启动redox

默认使用的是QEMU，所以你需要先在宿主机上安装好QEMU。注意，在docker容器当中是无法启动QEMU的。例如在MacOS Mojave上，可以通过brew安装QEMU：

```bash
brew install qemu
```

然后在宿主机上执行：

```bash
make qemu_no_build
```

就可以启动redox。

第一次启动回问你是不是要保存一个什么，输入yes
