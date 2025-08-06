$(function () {
  const path = location.pathname;

  // Initialize menu state: close all menus and reset icons
  function resetMenuState() {
    $('.one-depth')
        .removeClass('active')
        .find('ul')
        .hide();
    $('.one-depth-btn').each(function () {
      $(this).find('img:first').css('filter', 'none');
      $(this).find('img:last').attr('src', '/resources/cms/img/sideMenu/expansion.svg');
    });
  }

  // Update icon styles based on active state
  function updateIcons($oneDepth, isActive) {
    const $img1 = $oneDepth.find('.one-depth-btn img:first');
    const $img2 = $oneDepth.find('.one-depth-btn img:last');
    $img1.css('filter', isActive ? 'brightness(0) invert(1)' : 'none');
    $img2.attr('src', `/resources/cms/img/sideMenu/${isActive ? 'reduction' : 'expansion'}.svg`);
  }

  // Activate menu based on current path
  function activateMenu() {
    $('.menu-list a').each(function () {
      if (this.pathname === path) {
        const $oneDepth = $(this).closest('.one-depth');
        $(this).closest('li').addClass('active').parents('ul').show();
        $oneDepth.addClass('active');
        updateIcons($oneDepth, true);
      }
    });

    // Activate top-level menu based on path
    const activeMenu = path.includes('memberGroupAuth')
        ? '#memberGroupAuth'
        : /member|accountLock|loginLog/.test(path)
            ? '#memberGroup'
            : path.includes('adminMenu')
                ? '#cmsAdminManage'
                : !path.includes('/sjs/index.do')
                    ? '#cmsManage'
                    : null;
    $(activeMenu).addClass('active');
  }

  // Toggle side menu open/closed state
  $('.side-menu-toggle-btn').on('click', function () {
    $('.side-menu').toggleClass('closed');
    $('.container-box').toggleClass('expanded');

    if ($('.side-menu').hasClass('closed')) {
      $('.one-depth').each(function () {
        const $oneDepth = $(this);
        $oneDepth.find('ul').slideUp(10);
        updateIcons($oneDepth, $oneDepth.hasClass('active'));
      });
    }
  });

  // Handle menu toggle on click
  $('.menu-list .one-depth-btn').on('click', function () {
    const $parent = $(this).closest('.one-depth');
    const $subMenu = $parent.find('ul');

    // Redirect if no submenu exists
    if (!$subMenu.length) {
      return (location.href = $parent.find('div').text());
    }

    // Open side menu and expand submenu if closed
    if ($('.side-menu').hasClass('closed')) {
      $('.side-menu').removeClass('closed');
      $('.container-box').removeClass('expanded');
      resetMenuState();
      $parent.addClass('active');
      $subMenu.slideDown(100);
      updateIcons($parent, true);
      return;
    }

    // Toggle submenu visibility
    const isActive = $parent.hasClass('active');
    resetMenuState();
    if (!isActive) {
      $parent.addClass('active');
      $subMenu.slideDown(100);
      updateIcons($parent, true);
    }
  });

  // Initialize menu on page load
  resetMenuState();
  activateMenu();
});