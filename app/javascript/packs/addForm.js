let formNum = 0

//ページがロードされると...
window.addEventListener("load", function () {
  
  //材料追加ボタンの要素をidから取得
  const addButton = document.getElementById("add-btn");

  //取得したボタンをクリックすると...
  addButton.addEventListener("click", function() {

    //1行目で変数宣言したformNumに1を足す。(formNumに1が＋される)
    formNum += 1

    //材料と分量のフォーム、削除ボタンを取得,formListに代入
    const formList = document.getElementById("ingredient-main")

    //html要素を取り出し記入,idとplaceholderの0に指定していたところに
    //${formNum}を挿入することで、一つ目のフォームにはingredient-name_0、
    //二つ目はingredient-name_1、三つ目はingredient-name_2と足されていく
    const html = ` <div id="ingredient-form">
                    <div id="add-form">
                      <input id="ingredient-name_${formNum}" placeholder="材料-${formNum}" type="text" name="repertoire[ingredients_attributes][${formNum}][name]">
                    </div>
                    <div id="add-form">
                      <input id="ingredient-amount_${formNum}" placeholder="分量-${formNum}" type="text" name="repertoire[ingredients_attributes][${formNum}][amount]">                    </div>
                    <div class="delete" id='add-form'>
                      <button type="button" id="ingredient-btn_${formNum}" class="delete-btn" >
                        削除
                      </button>
                    </div>
                  </div>`;

    //insertAdjacentHTMLでノードを複製、挿入場所を16行目で定義したformList内に指定する。
    //引数のbeforeendで複製場所を末尾に指定,htmlで複製するものを指定する。
    //この一行での処理を要約すると、
    //『(html)を複製(insertAdjacentHTML)し、(formList)の末尾(beforeend)に挿入する』
    formList.insertAdjacentHTML('beforeend', html);




    //全ての削除ボタンを取得、deleteBtnsに定義する
    const deleteBtns = document.querySelectorAll('.delete-btn')

    //削除ボタンをforEachで繰り返し処理
    deleteBtns.forEach((btn) => {
      //deleteBtns要素(btn)をクリックすると53行目sample関数が実行される
      btn. addEventListener('click', sample)
})
  })
  //deleteBtnsのparentNode(親ノード)のさらにparentNode(親ノード)をremove(削除)する関数
  function sample() {
    this.parentNode.parentNode.remove()
  }

})