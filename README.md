# minimalpacker
出来る限り最小の構成で [packer.io](https://www.packer.io) を使って [vagrantup.com](https://www.vagrantup.com) のための [VirtualBox.org](https://www.virtualbox.org) 仮想マシンを作成します。  
Minimal procedure as possible for [packer.io](https://www.packer.io) and [vagrantup.com](https://www.vagrantup.com) with [VirtualBox.org](https://www.virtualbox.org)

便利さや柔軟さを目指すのではなく、シンプルであることを方針としています。  
Not convenient, Not flexible, It's just that simple.

### What you get
vagrantup.com に記述のある [デフォルトのユーザー設定](https://www.vagrantup.com/docs/boxes/base.html#default-user-settings) と [Guest Additions のインストール](https://www.vagrantup.com/docs/virtualbox/boxes.html#virtualbox-guest-additions) の要件のうち、以下のリストを満たした box が作成されます。  
作成される box ファイルの大きさは、約 1GB です。  
You'll get a box (packaged VM) that is granted with below.  
The box file size is 1GB roughly.

- SSH を使って "vagrant" ユーザーでログインできること。  
  SSH account "vagrant" is available.
- ”root” ユーザーのパスワードが "vagrant" であること。  
  "root" password is "vagrant".
- ”vagrant” ユーザーがパスワード無しで sudo を実行できること。  
  Account "vagrant" can use sudo command without password.
- Guest Additions がインストールされていること。  
  Guest Additions is installed.
- 仮想マシン内の `/vagrant` ディレクトリがホスト側と共有されていること。  
  VM's `/vagrant` directory is shared with Host-side.

### What you do
1. インストール用 ISO ファイルをダウンロードしておき、そのファイル名とチェックサム文字列を JSON ファイルに記述する。  
   Download Installer ISO file. And write ISO's filename and checksum to JSON.
2. `packer build` を実行して、拡張子 `.box` を持つ box ファイルを作成する。  
   `packer build` makes the box file that has `.box` extension.
3. 作成した box ファイルを `vagrant box add` で vagrant の管理に追加する。  
   `vagrant box add` manages the box file.

```
PS $env:USERPROFILE\mini-pack> ls -name
docker-install-ubuntu.sh
guestadditions-install.sh
guestadditions-prepare.sh
preseed-ubuntu.cfg
sample-ubuntu.json
ubuntu1704mini.iso

PS $env:USERPROFILE\mini-pack> packer build .\sample-ubuntu.json

PS path\to\workdir> ls -name
activate-nic2.sh
Vagrantfile

PS path\to\workdir> vagrant box add $env:USERPROFILE\mini-pack\packer_virtualbox-iso_virtualbox.box

PS path\to\workdir> vagrant up
```

インストール用の ISO ファイルとそのチェックサム文字列が必要となります。  
You need some Installer ISO file and ISO's checksum.

大抵の場合は `netboot/mini.iso` が使い勝手が良く軽量です。  
`netboot/mini.iso` is appropriate and light-weight as usual.

```
http://archive.ubuntu.com/ubuntu/dists/zesty/main/installer-amd64/current/images/netboot/mini.iso
http://archive.ubuntu.com/ubuntu/dists/zesty/main/installer-amd64/current/images/SHA256SUMS
```

### Requirements
本稿では Windows 10 Home 64bit をホストマシンとして用いています。  
`packer.exe` は `vagrant.exe` と同じディレクトリに置かれています。  
In this article, We use Windows 10 Home 64bit as host machine.  
`packer.exe` is placed in the folder where `vagrant.exe` is.

```
PS $env:USERPROFILE\mini-pack> packer -v
1.1.3
```

```
PS $env:USERPROFILE\mini-pack> vagrant -v
Vagrant 2.0.1
```

```
PS C:\Program Files\Oracle\VirtualBox> .\vboxmanage -v
5.2.4r119785
```

macOS の場合は [packer.io](https://www.packer.io), [vagrantup.com](https://www.vagrantup.com), [VirtualBox.org](https://www.virtualbox.org) の全てを Homebrew でインストールできます。  
If you use macOS, Homebrew manages all [packer.io](https://www.packer.io), [vagrantup.com](https://www.vagrantup.com), [VirtualBox.org](https://www.virtualbox.org).