import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import { Button } from '@/components/ui/button';
import {
  Dialog,
  DialogClose,
  DialogContent,
  DialogDescription,
  DialogFooter,
  DialogHeader,
  DialogTitle,
} from '@/components/ui/dialog';
import { DropdownMenu, DropdownMenuLabel } from '@/components/ui/dropdown-menu';
import { Field, FieldGroup, FieldLabel } from '@/components/ui/field';
import { Input } from '@/components/ui/input';
import { Label } from '@/components/ui/label';
import { Textarea } from '@/components/ui/textarea';
import MoreHorizontal from '~icons/lucide/more-horizontal';
import { fn } from '@ember/helper';

export default class DropdownMenuDialogDemo extends Component {
  @tracked showNewDialog = false;
  @tracked showShareDialog = false;

  setShowNewDialog = (open: boolean) => {
    this.showNewDialog = open;
  };

  setShowShareDialog = (open: boolean) => {
    this.showShareDialog = open;
  };

  <template>
    <DropdownMenu as |dm|>
      <dm.Trigger @asChild={{true}}>
        <Button @variant="outline" @size="icon-sm" aria-label="Open menu">
          <MoreHorizontal />
        </Button>
      </dm.Trigger>
      <dm.Content @class="w-40" @align="end" as |c|>
        <DropdownMenuLabel>File Actions</DropdownMenuLabel>
        <c.Group as |g|>
          <g.Item @onSelect={{fn this.setShowNewDialog true}}>
            New File...
          </g.Item>
          <g.Item @onSelect={{fn this.setShowShareDialog true}}>
            Share...
          </g.Item>
          <g.Item @disabled={{true}}>Download</g.Item>
        </c.Group>
      </dm.Content>
    </DropdownMenu>

    <Dialog
      @open={{this.showNewDialog}}
      @onOpenChange={{this.setShowNewDialog}}
    >
      <DialogContent @class="sm:max-w-[425px]">
        <DialogHeader>
          <DialogTitle>Create New File</DialogTitle>
          <DialogDescription>
            Provide a name for your new file. Click create when you're done.
          </DialogDescription>
        </DialogHeader>
        <FieldGroup class="pb-3">
          <Field>
            <FieldLabel for="filename">File Name</FieldLabel>
            <Input id="filename" name="filename" placeholder="document.txt" />
          </Field>
        </FieldGroup>
        <DialogFooter>
          <DialogClose @asChild={{true}}>
            <Button @variant="outline">Cancel</Button>
          </DialogClose>
          <Button type="submit">Create</Button>
        </DialogFooter>
      </DialogContent>
    </Dialog>

    <Dialog
      @open={{this.showShareDialog}}
      @onOpenChange={{this.setShowShareDialog}}
    >
      <DialogContent @class="sm:max-w-[425px]">
        <DialogHeader>
          <DialogTitle>Share File</DialogTitle>
          <DialogDescription>
            Anyone with the link will be able to view this file.
          </DialogDescription>
        </DialogHeader>
        <FieldGroup class="py-3">
          <Field>
            <Label for="email">Email Address</Label>
            <Input
              id="email"
              name="email"
              type="email"
              placeholder="shadcn@vercel.com"
              autocomplete="off"
            />
          </Field>
          <Field>
            <FieldLabel for="message">Message (Optional)</FieldLabel>
            <Textarea
              id="message"
              name="message"
              placeholder="Check out this file"
            />
          </Field>
        </FieldGroup>
        <DialogFooter>
          <DialogClose @asChild={{true}}>
            <Button @variant="outline">Cancel</Button>
          </DialogClose>
          <Button type="submit">Send Invite</Button>
        </DialogFooter>
      </DialogContent>
    </Dialog>
  </template>
}
