# minimalpacker
出来る限り最小の手順で [packer.io](https://www.packer.io) を使って [vagrantup.com](https://www.vagrantup.com) のための [VirtualBox.org](https://www.virtualbox.org) ファイルを作成します。  
Minimal (as possible) procedure for [packer.io](https://www.packer.io) and [vagrantup.com](https://www.vagrantup.com) with [VirtualBox.org](https://www.virtualbox.org)

便利さや柔軟さを目指すのではなく、シンプルであることを方針としています。  
Not convenient, Not flexible, It's just that simple.

#### What you get
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
- 仮想マシン内の `/vagrant` ディレクトリがホスト側と共有されているいること。  
  VM's `/vagrant` directory is shared with Host-side.

#### What you do
1. ISO ファイルをダウンロードしておき、そのチェックサム文字列を JSON ファイルに記述する。  
   Download ISO file. And write ISO's checksum to JSON.
2. `packer build` を実行する。  
   Execute `packer build`.

```
PS $env:USERPROFILE\mini-pack> ls -name
guestadditions-install.sh
guestadditions-prepare.sh
preseed-ubuntu.cfg
sample-ubuntu.json
ubuntu1704mini.iso

PS $env:USERPROFILE\mini-pack> packer build .\sample-ubuntu.json
```

インストール用の ISO ファイルとそのチェックサム文字列が必要となります。  
You need some ISO file and ISO's checksum.

大抵の場合は `netboot/mini.iso` が使い勝手が良く軽量です。  
`netboot/mini.iso` is appropriate and light-weight as usual.

```
http://archive.ubuntu.com/ubuntu/dists/zesty/main/installer-amd64/current/images/netboot/mini.iso
http://archive.ubuntu.com/ubuntu/dists/zesty/main/installer-amd64/current/images/SHA256SUMS
```

#### Requirements
```
PS $env:USERPROFILE\mini-pack> packer -v
1.1.3
```

本稿では Windows 10 Home 64bit をホストマシンとして用いています。  
`packer.exe` は `vagrant.exe` と同じディレクトリに置かれています。  
In this article, We use Windows 10 Home 64bit as host machine.  
`packer.exe` is placed in the folder where `vagrant.exe` is.

```
PS $env:USERPROFILE\mini-pack> vagrant -v
Vagrant 2.0.1
```

```
PS C:\Program Files\Oracle\VirtualBox> .\vboxmanage -v
5.2.4r119785
```

## Questions and My Guesses
実際の作業の上で生じた疑問点と、それに対する（回答というよりは）推測などを以下にまとめます。  
Questions encounted in this article and My Guesses (rather than Answers) are as follows.

#### LF or CR-LF
各ファイルの改行コードは LF でも CR-LF でも問題は無いようです。  
Each file allows LF or CR-LF as "line break" character.

- JSON ファイルの改行は `packer` が扱う。  
  `packer` cares line break in JSON file.
- preseed ファイルの改行は HTTP サービスが扱う。([参照>RFC7231](https://tools.ietf.org/html/rfc7231#section-3.1.1.3))  
  HTTP cares line break in preseed file.([Ref>RFC7231](https://tools.ietf.org/html/rfc7231#section-3.1.1.3))
- `packer` の `"provisioners"` は、実行する `"scripts"` を一時ファイルとしてコピーしたものを使う。  
  `"provisioners"` of `packer` uses temporary copies of `"scripts"`.
- `Vagrantfile` は ruby で実行される。  
  `Vagrantfile` is ruby script.

#### kill-all-dhcp; netcfg
HTTP で preseed ファイルを渡す場合は `netcfg` で指定した項目が反映されません。([参照>Debian GNU/Linux インストールガイド B.4.2.](https://www.debian.org/releases/stable/amd64/apbs04.html))  
`netcfg` parameters in a preseed file transferred with HTTP does not work.([Ref>Debian GNU/Linux Installation Guide B.4.2.](https://www.debian.org/releases/stable/amd64/apbs04.html))

#### config.ssh.password

For the first time only, `Vagrantfile` needs `config.ssh.password` parameter.

本稿の手順では `packer` による仮想マシンの作成時に [insecure keypair](https://www.vagrantup.com/docs/boxes/base.html#quot-vagrant-quot-user) を配置していない。  
そのため、初回のみ `Vagrantfile` で `config.ssh.password` を指定していないと起動に失敗する。  
In this article, [insecure keypair](https://www.vagrantup.com/docs/boxes/base.html#quot-vagrant-quot-user) is not placed into account `vagrant`'s .ssh/authorized_keys file.  
Therefore, `Vagrantfile` needs `config.ssh.password` parameter, for the first startup only.
