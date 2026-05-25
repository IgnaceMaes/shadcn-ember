import { on } from '@ember/modifier';
import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';

import { Button } from '@/components/ui/button';
import {
  Drawer,
  DrawerClose,
  DrawerContent,
  DrawerDescription,
  DrawerFooter,
  DrawerHeader,
  DrawerTitle,
  DrawerTrigger,
} from '@/components/ui/drawer';

export default class DrawerDemo extends Component {
  @tracked goal = 350;

  handleDecrement = () => {
    this.goal = Math.max(200, Math.min(400, this.goal - 10));
  };

  handleIncrement = () => {
    this.goal = Math.max(200, Math.min(400, this.goal + 10));
  };

  <template>
    <Drawer>
      <DrawerTrigger @asChild={{true}}>
        <Button @variant="outline">Open Drawer</Button>
      </DrawerTrigger>
      <DrawerContent>
        <div class="mx-auto w-full max-w-sm">
          <DrawerHeader>
            <DrawerTitle>Move Goal</DrawerTitle>
            <DrawerDescription>Set your daily activity goal.</DrawerDescription>
          </DrawerHeader>
          <div class="p-4 pb-0">
            <div class="flex items-center justify-center space-x-2">
              <Button
                @class="h-8 w-8 shrink-0 rounded-full"
                @disabled={{this.isMinGoal}}
                @size="icon"
                @variant="outline"
                {{on "click" this.handleDecrement}}
              >
                <span class="sr-only">Decrease</span>
                −
              </Button>
              <div class="flex-1 text-center">
                <div class="text-7xl font-bold tracking-tighter">
                  {{this.goal}}
                </div>
                <div
                  class="text-[0.70rem] text-muted-foreground uppercase"
                >Calories/day</div>
              </div>
              <Button
                @class="h-8 w-8 shrink-0 rounded-full"
                @disabled={{this.isMaxGoal}}
                @size="icon"
                @variant="outline"
                {{on "click" this.handleIncrement}}
              >
                <span class="sr-only">Increase</span>
                +
              </Button>
            </div>
          </div>
          <DrawerFooter>
            <Button>Submit</Button>
            <DrawerClose @asChild={{true}}>
              <Button @variant="outline">Cancel</Button>
            </DrawerClose>
          </DrawerFooter>
        </div>
      </DrawerContent>
    </Drawer>
  </template>

  get isMinGoal() {
    return this.goal <= 200;
  }

  get isMaxGoal() {
    return this.goal >= 400;
  }
}
