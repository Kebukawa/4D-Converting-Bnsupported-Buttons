# 4D-Converting-Bnsupported-Buttons

プロジェクトモードでサポートされないボタンのデザインをできるだけ元のように戻すコンポーネント。

対象となるボタンは…

1. ハイライトボタン
2. 背景オフセットボタン

## インストール方法

プロジェクトに変換した後に、プロジェクトのコンポーネントとして`ButtonConberter.4Dbase`をインストールします。

## 変換作業

問題のプロジェクトからコンポーネントメソッドの`BC_ConvertButtons`を実行してください。

> [!NOTE]
> Logsフォルダーの中にプロジェクト変換時に生成されたログ（例`Conversion 9999-99-99T99-99-99.json`）ファイルが存在する必要があります。

## 変換の内容

ボタンの見た目が問題になりますので、問題のボタンの見た目を変更するためのクラスをCSSで定義します。
クラスでは、以前と同じように変化を表現したSVGがリンクされています。

CSSとSVGで以前と同じように振る舞うボタンを表現していますが、まったく同じではありませんので、その点はご容赦ください。

## Special thanks

制作にあたり⇓の投稿を参考にしました。

> [Replace highlight buttons with custom SVG buttons](https://discuss.4d.com/t/replace-highlight-buttons-with-custom-svg-buttons/31719)
