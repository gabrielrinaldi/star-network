import { Controller } from '@hotwired/stimulus';
import { enter, leave } from 'el-transition';

export default class extends Controller {
  static targets = ['container', 'menu'];

  showMenu() {
    this.menuTarget.classList.remove('hidden');
    enter(this.menuTarget);
  }

  hideMenu(event) {
    if (event && this.containerTarget.contains(event.target)) {
      return;
    }

    Promise.all([leave(this.menuTarget)])
      .then(() => {
        this.menuTarget.classList.add('hidden');
      })
      .catch(() => {
        this.menuTarget.classList.add('hidden');
      });
  }
}
