import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import { fn } from '@ember/helper';
import { on } from '@ember/modifier';
import { Button } from '@/components/ui/button';
import { Dialog } from '@/components/ui/dialog';
import { Input } from '@/components/ui/input';
import { Label } from '@/components/ui/label';

export default class DialogDemo extends Component {
  @tracked name = 'Pedro Duarte';
  @tracked username = '@peduarte';

  handleSubmit = (event: SubmitEvent, setOpen: (open: boolean) => void) => {
    event.preventDefault();
    const formData = new FormData(event.target as HTMLFormElement);
    this.name = formData.get('name') as string;
    this.username = formData.get('username') as string;
    setOpen(false);
  };

  <template>
    <Dialog as |d|>
      <d.Trigger>
        <Button @variant="outline">Open Dialog</Button>
      </d.Trigger>
      <d.Content @class="sm:max-w-[425px]" as |setOpen|>
        <form {{on "submit" (fn this.handleSubmit setOpen)}}>
          <d.Header>
            <d.Title>Edit profile</d.Title>
            <d.Description>
              Make changes to your profile here. Click save when you're done.
            </d.Description>
          </d.Header>
          <div class="grid gap-4">
            <div class="grid gap-3">
              <Label @for="name-1">Name</Label>
              <Input id="name-1" name="name" value={{this.name}} />
            </div>
            <div class="grid gap-3">
              <Label @for="username-1">Username</Label>
              <Input id="username-1" name="username" value={{this.username}} />
            </div>
          </div>
          <d.Footer>
            <d.Close>
              <Button @variant="outline">Cancel</Button>
            </d.Close>
            <Button type="submit">Save changes</Button>
          </d.Footer>
        </form>
      </d.Content>
    </Dialog>
  </template>
}
