import { Controller } from '@hotwired/stimulus';
import { enter, leave } from 'el-transition';

export default class extends Controller {
  static targets = ['menu', 'open', 'close'];

  showMenu() {
    this.menuTarget.classList.remove('hidden');
    this.openTarget.classList.add('hidden');
    this.closeTarget.classList.remove('hidden');
  }

  hideMenu(event) {
    if (event && event.key !== undefined && event.key !== 'Escape') {
      return;
    }

    leave(this.menuTarget);
    this.menuTarget.classList.add('hidden');
    this.openTarget.classList.remove('hidden');
    this.closeTarget.classList.add('hidden');
  }

  toggleMenu() {
    if (this.menuTarget.classList.contains('hidden')) {
      this.showMenu();
    } else {
      this.hideMenu();
    }
  }
}
