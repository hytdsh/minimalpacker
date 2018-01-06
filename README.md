# minimalpacker
出来る限り最小の手数で [packer.io](https://www.packer.io) を動かす。  
Minimal (as possible) procedure for [packer.io](https://www.packer.io) and [vagrantup.com](https://www.vagrantup.com) with [VirtualBox.org](https://www.virtualbox.org)

便利さや柔軟さではなく、シンプルであること。  
Not convenient, Not flexible, It's just that simple.

### usage example
```
PS $env:USERPROFILE\mini-pack> ls -name
guestadditions-install.sh
guestadditions-prepare.sh
preseed-ubuntu.cfg
sample-ubuntu.json
ubuntu1704mini.iso

PS $env:USERPROFILE\mini-pack> packer build ./sample-ubuntu.json
```
インストール用の ISO ファイルとそのチェックサム文字列が必要となる。  
You need some ISO file and ISO's checksum.

大抵の場合は `netboot/mini.iso` が軽量で使い勝手が良い。  
`netboot/mini.iso` is light-weight and appropriate as usual.
```
http://jp.archive.ubuntu.com/ubuntu/dists/zesty/main/installer-amd64/current/images/netboot/mini.iso
http://jp.archive.ubuntu.com/ubuntu/dists/zesty/main/installer-amd64/current/images/SHA256SUMS
```

### requirements
```
PS $env:USERPROFILE\mini-pack> packer -v
1.1.3
```
Windows 環境においては、もし可能であれば `packer.exe` を `vagrant.exe` と同じディレクトリに置くようにすると、パスを通す必要もなくファイアウォールの許可も一度で済む。  
In Windows host, `packer.exe` could be placed in the folder where `vagrant.exe` is placed, if possible.

```
PS $env:USERPROFILE\mini-pack> vagrant -v
Vagrant 2.0.1
```

```
PS C:\Program Files\Oracle\VirtualBox> ./vboxmanage -v
5.2.4r119785
```
