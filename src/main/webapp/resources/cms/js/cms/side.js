$(function () {
  const path = location.pathname;

  // 초기 상태: 모든 원뎁스 메뉴 닫기, 아이콘 초기화
  $('.one-depth').removeClass('active').find('ul').hide();
  $('.one-depth-btn').each(function () {
    $(this).find('img:first').css('filter', 'none'); // #999999 (기본 색상)
    $(this).find('img:last').attr('src', '/resources/cms/img/sideMenu/expansion.svg');
  });

  // 메뉴 활성화
  $('.menu-list a').each(function () {
    if (this.pathname === path) {
      const $oneDepth = $(this).closest('.one-depth');
      $(this).closest('li').addClass('active').parents('ul').show();
      $oneDepth.addClass('active');
      $oneDepth.find('.one-depth-btn img:first').css('filter', 'brightness(0) invert(1)'); // #FFF
      $oneDepth.find('.one-depth-btn img:last').attr('src', '/resources/cms/img/sideMenu/reduction.svg');
    }
  });

  // 대분류 활성화
  const activeMenu = path.includes('memberGroupAuth') ? '#memberGroupAuth' :
      /member|accountLock|loginLog/.test(path) ? '#memberGroup' :
          !path.includes('adminMenu') && !path.includes('/wbuilder/index.do') ? '#cmsManage' : null;
  $(activeMenu).addClass('active');

  // aside 메뉴 토글
  $('.menu-list .one-depth-btn').on('click', function () {
    const parent = $(this).closest('.one-depth');
    const subMenu = parent.find('ul');

    if (!subMenu.length) return location.href = parent.find('div').text();

    const isActive = parent.hasClass('active');
    $('.one-depth').removeClass('active').find('ul').slideUp(100);
    $('.one-depth-btn').each(function () {
      $(this).find('img:first').css('filter', 'none'); // #999999
      $(this).find('img:last').attr('src', '/resources/cms/img/sideMenu/expansion.svg');
    });

    if (!isActive) {
      parent.addClass('active');
      subMenu.slideDown(100);
      $(this).find('img:first').css('filter', 'brightness(0) invert(1)'); // #FFF
      $(this).find('img:last').attr('src', '/resources/cms/img/sideMenu/reduction.svg');
    }
  });
});