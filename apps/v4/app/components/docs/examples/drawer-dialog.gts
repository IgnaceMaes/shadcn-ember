import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';

import { Button } from '@/components/ui/button';
import {
  Dialog,
  DialogContent,
  DialogDescription,
  DialogHeader,
  DialogTitle,
  DialogTrigger,
} from '@/components/ui/dialog';
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
import { Input } from '@/components/ui/input';
import { Label } from '@/components/ui/label';
import { cn } from '@/lib/utils';

import type { TOC } from '@ember/component/template-only';
import type Owner from '@ember/owner';

export default class DrawerDialogDemo extends Component {
  @tracked open = false;
  @tracked isDesktop = window.matchMedia('(min-width: 768px)').matches;

  constructor(owner: Owner, args: Record<string, never>) {
    super(owner, args);
    this.mediaQuery = window.matchMedia('(min-width: 768px)');
    this.handleMediaChange(this.mediaQuery);
    this.mediaQuery.addEventListener('change', this.handleMediaChange);
  }

  willDestroy(): void {
    super.willDestroy();
    this.mediaQuery?.removeEventListener('change', this.handleMediaChange);
  }

  private mediaQuery: MediaQueryList | null = null;

  handleMediaChange = (e: MediaQueryListEvent | MediaQueryList) => {
    this.isDesktop = e.matches;
  };

  setOpen = (value: boolean) => {
    this.open = value;
  };

  <template>
    {{#if this.isDesktop}}
      <Dialog @onOpenChange={{this.setOpen}} @open={{this.open}}>
        <DialogTrigger>
          <Button @variant="outline">Edit Profile</Button>
        </DialogTrigger>
        <DialogContent @class="sm:max-w-[425px]">
          <DialogHeader>
            <DialogTitle>Edit profile</DialogTitle>
            <DialogDescription>
              Make changes to your profile here. Click save when you're done.
            </DialogDescription>
          </DialogHeader>
          <ProfileForm />
        </DialogContent>
      </Dialog>
    {{else}}
      <Drawer @onOpenChange={{this.setOpen}} @open={{this.open}}>
        <DrawerTrigger @asChild={{true}}>
          <Button @variant="outline">Edit Profile</Button>
        </DrawerTrigger>
        <DrawerContent>
          <DrawerHeader @class="text-left">
            <DrawerTitle>Edit profile</DrawerTitle>
            <DrawerDescription>
              Make changes to your profile here. Click save when you're done.
            </DrawerDescription>
          </DrawerHeader>
          <ProfileForm @class="px-4" />
          <DrawerFooter @class="pt-2">
            <DrawerClose @asChild={{true}}>
              <Button @variant="outline">Cancel</Button>
            </DrawerClose>
          </DrawerFooter>
        </DrawerContent>
      </Drawer>
    {{/if}}
  </template>
}

interface ProfileFormSignature {
  Element: HTMLFormElement;
  Args: {
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

const ProfileForm: TOC<ProfileFormSignature> = <template>
  <form class={{cn "grid items-start gap-6" @class}} ...attributes>
    <div class="grid gap-3">
      <Label @for="email">Email</Label>
      <Input id="email" type="email" value="shadcn@example.com" />
    </div>
    <div class="grid gap-3">
      <Label @for="username">Username</Label>
      {{! template-lint-disable no-potential-path-strings }}
      <Input id="username" value="@shadcn" />
    </div>
    <Button type="submit">Save changes</Button>
  </form>
</template>;
