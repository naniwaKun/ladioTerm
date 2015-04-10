# ladioTerm

ねとらじをターミナルで聞くクライアント、録音もできる。

Xによるデスクトップ環境には非依存です。

##依存関係

・bash

・ruby

・mpv：再生ソフト

・streamripper：録音ソフト


本スクリプトは、ねとらじのヘッドラインと連携して、streamripperとmpvをバックグラウンドで実行します。

Rubyからstreamripperを呼び出しますが、プロセスを管理しているのでcronと連携してデーモンにできます。重複録音はしないようになってます。

##インストール

archlinuxユーザーの方はPLGBUILDからビルドしてインストールしてください。

debian,ubuntu,linuxMint等のディストリビューションの方は、

・ladio

・ladioRec

・ladio.rb

以上のスクリプトを/usr/local/bin/の直下に設置してください。

##使い方

コマンド：$ ladio

番組表一覧を表示、番号で指定して再生。

コマンド：$ ladioRec　mountpoint

番組を録音する。放送中でないと録音できないのでクーロン等に登録してデーモン化してください。
/home/userdir/以下にladioディレクトリが自動生成されて、番組ごとに録音されます。同じ番組を多重で録音はできない仕様になっています。

