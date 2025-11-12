# 4D-Converting-Bnsupported-Buttons

バイナリーデータベースからプロジェクトデータベースに変換した際に、サポートされないボタンは標準のボタンとして生成されます。
そのようなボタンのデザインをできるだけ元のように戻すコンポーネントです。

対象となるボタンは…

1. ハイライトボタン
2. 背景オフセットボタン

## インストール方法

プロジェクトに変換した後に、その変換後のプロジェクトに、コンポーネントとして`ButtonConverter.4Dbase`をインストールします。

## 変換作業

問題のプロジェクトからコンポーネントメソッドの[BC_ConvertButtons](https://github.com/Kebukawa/4D-Converting-Bnsupported-Buttons/blob/main/ButtonConverter.4Dbase/Project/Sources/Methods/BC_ConvertButtons.4dm)を実行してください。

> [!NOTE]
> Logsフォルダーの中にプロジェクト変換時に生成されたログ（例`Conversion 9999-99-99T99-99-99.json`）ファイルが存在する必要があります。

変換後は、当コンポーネントを取り除いて問題ありません。

## 変換の内容

ボタンの見た目が問題になりますので、問題のボタンの見た目を変更するためのクラスをCSSで定義します。
クラスでは、以前と同じように変化を表現したSVGがリンクされています。

CSSとSVGで以前と同じように振る舞うボタンを表現していますが、まったく同じではありませんので、その点はご容赦ください。

## 動作条件

4D 20以降で動作します。
4D 19以前では動作しません。

## Special thanks

制作にあたり⇓の投稿を参考にしました。

> [Replace highlight buttons with custom SVG buttons](https://discuss.4d.com/t/replace-highlight-buttons-with-custom-svg-buttons/31719)
