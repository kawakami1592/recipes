$(document).on('turbolinks:load', function() {
  // $('form').find('file_field').removeAttr('required max min maxlength pattern');
  $(function(){
    // カテゴリーセレクトボックスのオプションを作成
    function categoryOption(category){
      var optionHtml = `<option value="${category.id}">${category.name}</option>`;
      return optionHtml;
    }
    // 親カテゴリー選択後のイベント
    $('#recipe_category_id').on('change', function(){
      let parentCategoryId = $(this).val();
      //選択された親カテゴリーのIDを取得
      if (parentCategoryId == ''){
        //親カテゴリーが空（初期値）の時
        $('#select-children').remove();
        $('#select-grandchildren').remove();
        //子と孫を削除するする
      }else{
        $.ajax({
          url: '/recipes/category_children',
          type: 'GET',
          data: { parent_id: parentCategoryId },
          dataType: 'json'
        })
        .done(function(category_children){
          $('#select-children').remove();
          $('#select-grandchildren').remove();
          //親が変更された時、子と孫を削除するする
          let optionHtml = '';
          category_children.forEach(function(child){
            optionHtml += categoryOption(child);
            //option要素を作成する
          });
          $('.new__main__top').append(
            `<div class="new__main__top__category" id="select-children">
              <label class="new__main__top__category__label" for="category_select_children">
                <select class="new__main__top__category__input" required="required" name="recipe[category_id]" id="category_select_children">
                  <option value="">カテゴリー</option>
                  ${optionHtml}
                </select>
                <i class="fas fa-chevron-down"></i>
              </label>
            </div>`);
        })
        .fail(function(){
          alert('カテゴリー取得に失敗しました');
        });
      }
    });
    // 子カテゴリー選択後のイベント
    $('.new__main__top').on('change', '#category_select_children', function(){
      let childrenCategoryId = $(this).val();
      //選択された子カテゴリーのIDを取得
      if (childrenCategoryId == ''){
        //子カテゴリーが空（初期値）の時
        $('#select-grandchildren').remove(); 
        //孫以下を削除する
      }else{
        $.ajax({
          url: '/recipes/category_grandchildren',
          type: 'GET',
          data: { child_id: childrenCategoryId },
          dataType: 'json'
        })
        .done(function(category_grandchildren){
          $('#select-grandchildren').remove();
          //子が変更された時、孫を削除するする
          let optionHtml = '';
          category_grandchildren.forEach(function(grandchildren){
            optionHtml += categoryOption(grandchildren);
            //option要素を作成する
          });
          $('.new__main__top').append(
            `<div class="new__main__top__category" id="select-grandchildren">
              <label class="new__main__top__category__label" for="category_select_grandchildren_id">
                <select class="new__main__top__category__input" required="required" name="recipe[category_id]" id="category_select_grandchildren_id">
                  <option value="">調理法</option>
                  ${optionHtml}
                </select>
                <i class="fas fa-chevron-down"></i>
              </label>
            </div>`);
        })
        .fail(function(){
          alert('カテゴリー取得に失敗しました');
        });
      }
    });
  });

  // メイン画像が選択された時プレビュー表示
  $('#image_input').on('change', function(e){

    //ファイルオブジェクトを取得する
    let files = e.target.files;
    $.each(files, function(i, file){
      let reader = new FileReader();

      //画像でない場合は処理終了
      if(file.type.indexOf("image") < 0){
        alert("画像ファイルを指定してください。");
        return false;
      }
      //アップロードした画像を設定する
      reader.onload = (function(file){
        return function(e){
          // プレビュー表示
          $('#image_input').append(
            `<div class="new__main__upper-half__left__figure">
              <img src="${e.target.result}" title="${file.name}" width="100%", height="100%", alt="メイン画像")>
              <div class="new__main__upper-half__left__figure__button">
                <a class="new__main__upper-half__left__figure__button__delete">削除</a>
              </div>
            </div>`);
          $("#image_input>label").css('display','none');
          // 入力されたlabelを非表示にする
        };
      })(file);
      reader.readAsDataURL(file);
    });
  });
  //削除ボタンが押された時
  $(document).on('click', '.new__main__upper-half__left__figure__button__delete', function(){
    $('#image_input').empty();
    //プレビュー、labelを削除
    $("#image_input").append(
      `<label class="new__main__upper-half__left__label" for="recipe_image">
        <input class="new__main__upper-half__left__label__input" required="required" placeholder="画像を選んでください" type="file" name="recipe[image]" id="recipe_image">
       <pre><i class="fas fa-camera fa-lg"></i>
クリックして画像を選んでください</pre>
      </label>`);
  });


  // 材料入力欄追加
  $('#add_ingredient').on('click', function(e){
    let ingredientLength = $('#ingredient_input').children('li').length;
    $('#ingredient_input').append(
      `<li class="new__main__upper-half__right__ingredients" id="ingredient_list_${ingredientLength}">
        <div class="new__main__upper-half__right__ingredients__name">
          <input class="new__main__upper-half__right__ingredients__name__input" required="required" placeholder="材料名" type="text" name="recipe[ingredients_attributes][${ingredientLength}][ingredient]" id="recipe_ingredients_attributes_${ingredientLength}_ingredient">
        </div>
        <div class="new__main__upper-half__right__ingredients__quantity">
          <input class="new__main__upper-half__right__ingredients__name__input" required="required" placeholder="分量" type="text" name="recipe[ingredients_attributes][${ingredientLength}][quantity]" id="recipe_ingredients_attributes_${ingredientLength}_quantity">
        </div>
        <div class="new__main__upper-half__right__ingredients__delete">
          <a class="new__main__upper-half__right__ingredients__delete__button" data-ingredients-delete-id="${ingredientLength}"><i class="fas fa-trash-alt"></i></a>
        </div>
      </li>`);
  });
  //削除ボタンが押された時
  $(document).on('click', '.new__main__upper-half__right__ingredients__delete__button', function(){
    let ingredientsDeleteId = $(this).data('ingredients-delete-id');
    $(`#ingredient_list_${ingredientsDeleteId}`).empty();

    const hiddenCheck = $(`input[data-ingredients-list-id="${ingredientsDeleteId}"].ingredien-hidden-destroy`);
  
    // もしチェックボックスが存在すればチェックを入れる
    if (hiddenCheck) hiddenCheck.prop('checked', true);
  });


  // 作り方入力欄追加
  $('#add_maked').on('click', function(e){
    let makedLength = $("#maked_input>li").eq(-1).data('maked-list-id');
    // #image-inputの子要素labelの中から最後の要素のカスタムデータidを取得
    $('#add_maked').before(
      `<li class="new__main__makedbox__list" id="makedbox_list_${makedLength+1}" data-maked-list-id="${makedLength+1}">
        <div class="new__main__makedbox__list__image" data-maked-id="${makedLength+1}" id="maked_image_${makedLength+1}">
          <label class="new__main__makedbox__list__image__label" for="recipe_makeds_attributes_${makedLength+1}_image">
            <input class="new__main__makedbox__list__image__label__input" placeholder="画像を選んでください" type="file" name="recipe[makeds_attributes][${makedLength+1}][image]" id="recipe_makeds_attributes_${makedLength+1}_image">
              <pre><i class="fas fa-camera fa-lg"></i>
画像を選んでください</pre>
          </label></div>
        <div class="new__main__makedbox__list__text">
          <textarea class="new__main__makedbox__list__text__input" placeholder="作り方を入力してください" name="recipe[makeds_attributes][${makedLength+1}][text]" id="recipe_makeds_attributes_${makedLength+1}_text"></textarea>
        </div>
        <div class="new__main__makedbox__list__delete">
          <a class="new__main__makedbox__list__delete__button" data-makedbox-delete-id="${makedLength+1}"><i class="fas fa-trash-alt"></i></a>
        </div>
      </li>`);
  });

  //削除ボタンが押された時
  $(document).on('click', '.new__main__makedbox__list__delete__button', function(){
    let makedboxDeleteId = $(this).data('makedbox-delete-id');
    $(`#makedbox_list_${makedboxDeleteId}`).remove();

    const hiddenCheck = $(`input[data-ingredients-list-id="${makedboxDeleteId}"].hidden-destroy`);
    // もしチェックボックスが存在すればチェックを入れる
    if (hiddenCheck) hiddenCheck.prop('checked', true);
  });

  // 作り方画像が選択された時プレビュー表示
  $(document).off('change', '.new__main__makedbox__list__image');
  $(document).on('change', '.new__main__makedbox__list__image', function(e){
    // イベント元のカスタムデータ属性の値を取得
    let makedImageId = $(this).data('maked-id');
    //ファイルオブジェクトを取得する
    let files = e.target.files;
    $.each(files, function(i, file){
      let reader = new FileReader();
      //画像でない場合は処理終了
      if(file.type.indexOf("image") < 0){
        alert("画像ファイルを指定してください。");
        return false;
      }
      // プレビュー表示
      reader.onload = (function(file){
        return function(e){
          $(`#maked_image_${makedImageId}`).append(
            `<div class="new__main__makedbox__list__image__figure">
              <img src="${e.target.result}" title="${file.name}" width="100%", height="100%", alt="参考画像")>
              <div class="new__main__makedbox__list__image__figure__button">
                <a class="new__main__makedbox__list__image__figure__button__delete" data-image-delete-id="${makedImageId}">削除</a>
              </div>
            </div>`);
          $(`#maked_image_${makedImageId}>label`).css('display','none');
          // 入力されたlabelを非表示にする
        };
      })(file);
      reader.readAsDataURL(file);
    });
  });
  //プレビューの削除ボタンが押された時
  $(document).on('click', '.new__main__makedbox__list__image__figure__button__delete', function(){
    let deleteId = $(this).data('image-delete-id');
    $(`#maked_image_${deleteId}`).empty();
    //プレビュー、labelを削除
    $(`#maked_image_${deleteId}`).append(
      `<label class="new__main__makedbox__list__image__label" for="recipe_makeds_attributes_${deleteId}_image">
      <input class="new__main__makedbox__list__image__label__input" placeholder="画像を選んでください" type="file" name="recipe[makeds_attributes][${deleteId}][image]" id="recipe_makeds_attributes_${deleteId}_image">
        <pre><i class="fas fa-camera fa-lg"></i>
画像を選んでください</pre>
    </label>`);
  });


  // 編集ページ読み込み時に発火
  var result = location.pathname.indexOf( 'edit' );
  // URLでパスの部分を取得・設定する
  if(result !== -1) {
    $('#image_input').append(
      `<div class="new__main__upper-half__left__figure">
        <img src="${gon.image.url}" title="${gon.image.name}" width="100%", height="100%", alt="メイン画像")>
        <div class="new__main__upper-half__left__figure__button">
          <a class="new__main__upper-half__left__figure__button__delete">削除</a>
        </div>
      </div>`);
    $("#image_input>label").css('display','none');

    $.each(gon.ingredients,function(index, maked) {
      $('.new__main__upper-half__right__ingredients').eq(index).attr('id', `ingredient_list_${index}`);
    });

    $.each(gon.makeds, function(index, maked) {
      if(maked.image.url == null) {
        $('.new__main__makedbox__list__image').eq(index).attr('data-maked-id', `${index}`);
        $('.new__main__makedbox__list__image').eq(index).attr('id', `maked_image_${index}`);
      }else{
        $('.new__main__makedbox__list').eq(index).attr('id', `makedbox_list_${index}`);
        $('.new__main__makedbox__list__image').eq(index).attr('data-maked-id', `${index}`);
        $('.new__main__makedbox__list__image').eq(index).attr('id', `maked_image_${index}`);
        $(`.new__main__makedbox__list__image`).eq(index).append(
          `<div class="new__main__makedbox__list__image__figure">
            <img src="${maked.image.url}" title="${maked.image}" width="100%", height="100%", alt="参考画像")>
          </div>`);
          $(`[for='recipe_makeds_attributes_${index}_image']`).css('display','none');
      };
    });
  };

});
