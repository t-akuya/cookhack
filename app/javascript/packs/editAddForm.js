
let i = 0

//ページがロードされると...
window.addEventListener("load", function () {
  
  //材料追加ボタンの要素をidから取得
  const addButton = document.getElementById("add-btn");
  let inputNum = document.getElementById("number").value;
  //取得したボタンをクリックすると...
  addButton.addEventListener("click", function() {

    //1行目で変数宣言したformNumに1を足す。(formNumに1が＋される)
    inputNum += 1
    i += 1
    //材料と分量のフォーム、削除ボタンを取得,formListに代入
    const formList = document.getElementById("ingredient-main")

    //html要素を取り出し記入,idとplaceholderの0に指定していたところに
    //${formNum}を挿入することで、一つ目のフォームにはingredient-name_0、
    //二つ目はingredient-name_1、三つ目はingredient-name_2と足されていく
    const html = `<div id="ingredient-main">
                    <div id="ingredient-form">
                      <div id="add-form">
                        <input placeholder="追加する材料${i}" type="text"
                        name="repertoire[ingredients_attributes][${inputNum}][name]" id="repertoire_ingredients_attributes_${inputNum}_name">
                      </div>
                      <div id="add-form">
                        <input placeholder="追加する分量${i}" type="text"
                        name="repertoire[ingredients_attributes][${inputNum}][amount]" id="repertoire_ingredients_attributes_${inputNum}_amount">
                      </div>
                      <div id="add-form" class="delete" >
                        <button type="button" name="repertoire[ingredients_attributes][${inputNum}][del]" id="repertoire_ingredients_attributes_${inputNum}_del" class="delete-btn" >
                         削除
                        </button>
                      </div>
                    </div>
                  </div>`;

    //insertAdjacentHTMLでノードを複製、挿入場所を17行目で定義したformList内に指定する。
    //引数のbeforeendで複製場所を末尾に指定,htmlで複製するものを指定する。
    //この一行での処理を要約すると、
    //『(html)を複製(insertAdjacentHTML)し、(formList)の末尾(beforeend)に挿入する』
    formList.insertAdjacentHTML('beforeend', html);

     //全ての削除ボタンを取得、deleteBtnsに定義する
     const deleteBtns = document.querySelectorAll('.delete-btn')
 
     //複数の削除ボタン(deleteBtns)をforEachで繰り返し処理,引数をbtnに設定
     deleteBtns.forEach((btn) => {
       //複数の削除ボタン=deleteBtns要素=(btn)をクリックすると引数del(64行目)の関数が発火
       btn. addEventListener('click', del)
     })
  })
    
     //全ての削除ボタンを取得、deleteBtnsに定義する
    //クリックイベントの関数内に記述することで追加ボタンを押下しないと削除ボタンが作動しないようにしている
    const deleteBtns = document.querySelectorAll('.delete-btn')

    //削除ボタンをforEachで繰り返し処理
    deleteBtns.forEach((btn) => {
      //deleteBtns要素(btn)をクリックすると53行目sample関数が実行される
      btn. addEventListener('click', del)
    })

    //関数delを定義
    //deleteBtnsのparentNode(親ノード)のさらにparentNode(親ノード)をremove(削除)する関数
    function del() {
      console.log(this)
      this.parentNode.parentNode.remove()
    }
  
})