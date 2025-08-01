$(function () {
  // 메뉴 토글 버튼
  $('.side-menu-toggle-btn').on('click', function () {
    $('.side-menu').toggleClass('closed');
    $('.container-box').toggleClass('expanded');

    if ($('.side-menu').hasClass('closed')) {
      // 닫힐 때: active 유지, 하위 메뉴 모두 숨기기
      $('.one-depth').each(function () {
        const isActive = $(this).hasClass('active');

        // 하위 메뉴 숨기기 (active여도 숨김)
        $(this).find('ul').slideUp(10);

        const $img1 = $(this).find('.one-depth-btn img:first');
        const $img2 = $(this).find('.one-depth-btn img:last');

        if (isActive) {
          $img1.css('filter', 'brightness(0) invert(1)');
          $img2.attr('src', '/resources/cms/img/sideMenu/reduction.svg');
        } else {
          $img1.css('filter', 'none');
          $img2.attr('src', '/resources/cms/img/sideMenu/expansion.svg');
        }
      });
    }
  });

  const path = location.pathname;

  // 초기 상태: 모든 원뎁스 메뉴 닫기, 아이콘 초기화
  $('.one-depth').removeClass('active').find('ul').hide();
  $('.one-depth-btn').each(function () {
    $(this).find('img:first').css('filter', 'none'); // 기본 색상
    $(this).find('img:last').attr('src', '/resources/cms/img/sideMenu/expansion.svg');
  });

  // 현재 경로에 해당하는 메뉴 활성화
  $('.menu-list a').each(function () {
    if (this.pathname === path) {
      const $oneDepth = $(this).closest('.one-depth');
      $(this).closest('li').addClass('active').parents('ul').show();
      $oneDepth.addClass('active');
      $oneDepth.find('.one-depth-btn img:first').css('filter', 'brightness(0) invert(1)');
      $oneDepth.find('.one-depth-btn img:last').attr('src', '/resources/cms/img/sideMenu/reduction.svg');
    }
  });

  // 대분류 자동 활성화
  const activeMenu = path.includes('memberGroupAuth') ? '#memberGroupAuth' :
      /member|accountLock|loginLog/.test(path) ? '#memberGroup' :
          !path.includes('adminMenu') && !path.includes('/wbuilder/index.do') ? '#cmsManage' : null;
  $(activeMenu).addClass('active');

  // 메뉴 펼침 토글
  $('.menu-list .one-depth-btn').on('click', function () {
    const parent = $(this).closest('.one-depth');
    const subMenu = parent.find('ul');

    // 서브메뉴 없으면 바로 이동
    if (!subMenu.length) {
      return location.href = parent.find('div').text();
    }

    // 사이드 메뉴 닫힌 상태라면 열고 해당 메뉴 펼치기
    if ($('.side-menu').hasClass('closed')) {
      $('.side-menu').removeClass('closed');
      $('.container-box').removeClass('expanded');

      $('.one-depth').removeClass('active').find('ul').slideUp(10);
      $('.one-depth-btn').each(function () {
        $(this).find('img:first').css('filter', 'none');
        $(this).find('img:last').attr('src', '/resources/cms/img/sideMenu/expansion.svg');
      });

      parent.addClass('active');
      subMenu.slideDown(100);
      $(this).find('img:first').css('filter', 'brightness(0) invert(1)');
      $(this).find('img:last').attr('src', '/resources/cms/img/sideMenu/reduction.svg');
      return;
    }

    // 기존 토글 동작
    const isActive = parent.hasClass('active');

    $('.one-depth').removeClass('active').find('ul').slideUp(10);
    $('.one-depth-btn').each(function () {
      $(this).find('img:first').css('filter', 'none');
      $(this).find('img:last').attr('src', '/resources/cms/img/sideMenu/expansion.svg');
    });

    if (!isActive) {
      parent.addClass('active');
      subMenu.slideDown(100);
      $(this).find('img:first').css('filter', 'brightness(0) invert(1)');
      $(this).find('img:last').attr('src', '/resources/cms/img/sideMenu/reduction.svg');
    }
  });
});
