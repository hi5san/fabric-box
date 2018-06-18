# fabric-box
Quick start vagrant box for Hyperledger Fabric

# Contains
- Ubuntu 18.04 LTS (bionic/beaver)
- Hyperledger Fabric v1.1.0 environment, and samples.

# Component diagram
![Diagram](https://raw.githubusercontent.com/hi5san/fabric-box/master/ubuntu1804_hlfv110/images/components.png)

# Install procedues
注意：インストーラーによってWindowsが再起動されます。
1. VirtualBoxをインストールする。  
https://www.virtualbox.org/wiki/Downloads  
"Windows Hosts"リンクからインストーラーをダウンロードして、実行。
2. Vagrantをインストールする。  
https://www.vagrantup.com/downloads.html
"Windows 64bit"リンクからインストーラーをダウンロードして、実行。
3. (Windows7のみ？）PowerShellをバージョン3にアップグレードする（WMF 5.1をインストールすることで行う）。    
注意：PowerShellのアップデートが出来ない状況であれば、古いVirtualBoxやvagrantバージョンを使うなどのワークアラウンドがあるらしいのでググってみてください。
4. https://docs.microsoft.com/ja-jp/powershell/wmf/5.1/install-configure  
"Windows 7 SP1" の "x64: Win7AndW2K....ZIP"リンクをクリックしてインストーラーをダウンロード。
5. ダウンロードしたZIPの中の"Win7AndW2K...msu"を実行してインストールする。

# Easy procedures for setting up virtual machine
1. Download the preconfigured [Vagrantfile](https://raw.githubusercontent.com/hi5san/fabric-box/master/ubuntu1804_hlfv110/Vagrantfile).
2. Windowsのコマンドプロンプトを開き、ダウンロードしたVagrantfileを使用してUbuntu 18.04仮想マシンと、その上にHyperledger Fabric v1.1.0およびサンプルをインストールする。  
&gt; mkdir hlf  
&gt; cd hlf  
&gt; copy ＜上でダウンロードしたファイル＞ Vagrantfile  
&gt; vagrant up  
10分はかかります。 
* Exit code -1073741819  
ここでVboxHardeningエラー（Stderr: VBoxManage.exe: error: The virtual machine 'XXXXXX' has terminated unexpectedly during startup with exit code -1073741819 (0xc0000005））が極々稀に起きるそうです。PC内のアンチウィルス、DLL破損（sfc /scannowで修復）などなどが原因と考えられていますが、そのどれでもない場合のワークアラウンドとして[ここ](https://forums.virtualbox.org/viewtopic.php?f=6&t=82277)にあるように、VBoxDrvのロード設定を変更するか、VirtualBox 4.3.12など古いバージョンのVirtualBoxでワークアラウンドできます。
3. 起動したUbuntu(仮想マシン)にログインする。  
&gt; vagrant ssh  
4. ログインしたらUbuntu上で確認  
$ ls -l fabric-samples  
$ cd fabric-samples/first-network  
$ ./byfn.sh -h  
5. Hyperledger Fabric readTheDocs (release-1.1)に従ってTutorials(byfn)などを実施します。

# Hints and Tips
## 仮想マシンの中断と再開
仮想マシンなのでいつでも動いている状態のままサスペンド（中断）して後で再開できます。  
- ログアウトする。  
- 中断 -> vagrant suspend
- 再開 -> vagrant resume
## 仮想マシンの停止
仮想マシンをシャットダウンする場合。  
- ログアウトする。  
&gt; vagrant halt
## 仮想マシンの削除
ローカル環境から完全削除します。  
- ログアウトする。  
&gt; vagrant destroy  
Vagrantfileは消えません。
## 仮想マシン(=Ubuntu LinuxゲストOS)とホストOS(=Windows)
- vagrant upを実行したフォルダは、ゲストOSの /vagrant ディレクトリにマウントされていますので、ファイルのやりとりに便利です。
- ホストOSから、ゲストOS上で動いているプログラムとネットワーク接続するには、「ポート・フォワーディング」（＝ホストOSのポート番号とゲストOSのポート番号を転送接続する機能）を使用できます。  
-- 仮想マシンを停止する（上記に手順）  
-- Vagrantfileを編集して、ポート・フォワーディング設定を追加する。  
下記のような例がVagrantfile内にコメントとして記述されているのでそれをコピーして作成する。  
例えば、ホストOSの 8888番ポートを、ゲストOSの8080番ポートに繋ぐ設定：  
config.vm.network :forwarded_port, guest: 8080, host: 8888  
-- 編集後、vagrant up を実行すればポート・フォワーディング設定が有効になります。  
-- ホストOSの localhost:8888番ポートにアクセスすることで、ゲストOSの8080番ポートで待ち受けているプログラムに接続することが出来るようになります。  
-- 確認  
--- ゲストOSで $ nc -l 8080　を実行（8080で待ち受ける）  
--- ホストOSのブラウザで http://localhost:8888/  にアクセス  
--- nc コマンドがブラウザ要求を出力します　（確認終わり）。  

## UbuntuのGUIを利用したい
- Ubuntuを起動・ログインする（vagrant up/vagrant ssh）。  
$ sudo apt-get install -y ubuntu-desktop  
- 5~10分くらいかかります。
- ログアウトして、仮想マシンを停止する。  
- Vagrantfileを編集して、vb.gui = true のコメント行を有効にする（先頭の "#"を削除）。  
- 仮想マシンを起動すると、GUIモードで起動する。  
- id: vagrant pass: vagrant でログインできる。

