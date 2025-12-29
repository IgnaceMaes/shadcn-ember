import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import { Button } from '@/components/ui/button';
import { ButtonGroup } from '@/components/ui/button-group';
import {
  DropdownMenu,
  DropdownMenuContent,
  DropdownMenuGroup,
  DropdownMenuItem,
  DropdownMenuRadioGroup,
  DropdownMenuRadioItem,
  DropdownMenuSeparator,
  DropdownMenuSub,
  DropdownMenuSubContent,
  DropdownMenuSubTrigger,
  DropdownMenuTrigger,
} from '@/components/ui/dropdown-menu';
import ArchiveIcon from '~icons/lucide/archive';
import ArrowLeftIcon from '~icons/lucide/arrow-left';
import CalendarPlusIcon from '~icons/lucide/calendar-plus';
import ClockIcon from '~icons/lucide/clock';
import ListFilterIcon from '~icons/lucide/list-filter';
import MailCheckIcon from '~icons/lucide/mail-check';
import MoreHorizontalIcon from '~icons/lucide/more-horizontal';
import TagIcon from '~icons/lucide/tag';
import Trash2Icon from '~icons/lucide/trash-2';

export default class ButtonGroupDemo extends Component {
  @tracked label = 'personal';

  handleLabelChange = (value: string) => {
    this.label = value;
  };

  <template>
    <ButtonGroup>
      <ButtonGroup class="hidden sm:flex">
        <Button @variant="outline" @size="icon" aria-label="Go Back">
          <ArrowLeftIcon />
        </Button>
      </ButtonGroup>
      <ButtonGroup>
        <Button @variant="outline">Archive</Button>
        <Button @variant="outline">Report</Button>
      </ButtonGroup>
      <ButtonGroup>
        <Button @variant="outline">Snooze</Button>
        <DropdownMenu>
          <DropdownMenuTrigger @asChild={{true}}>
            <Button @variant="outline" @size="icon" aria-label="More Options">
              <MoreHorizontalIcon />
            </Button>
          </DropdownMenuTrigger>
          <DropdownMenuContent @class="w-52">
            <DropdownMenuGroup>
              <DropdownMenuItem>
                <MailCheckIcon />
                Mark as Read
              </DropdownMenuItem>
              <DropdownMenuItem>
                <ArchiveIcon />
                Archive
              </DropdownMenuItem>
            </DropdownMenuGroup>
            <DropdownMenuSeparator />
            <DropdownMenuGroup>
              <DropdownMenuItem>
                <ClockIcon />
                Snooze
              </DropdownMenuItem>
              <DropdownMenuItem>
                <CalendarPlusIcon />
                Add to Calendar
              </DropdownMenuItem>
              <DropdownMenuItem>
                <ListFilterIcon />
                Add to List
              </DropdownMenuItem>
              <DropdownMenuSub>
                <DropdownMenuSubTrigger>
                  <TagIcon />
                  Label As...
                </DropdownMenuSubTrigger>
                <DropdownMenuSubContent>
                  <DropdownMenuRadioGroup
                    @value={{this.label}}
                    @onValueChange={{this.handleLabelChange}}
                    as |value setValue|
                  >
                    <DropdownMenuRadioItem
                      @value="personal"
                      @currentValue={{value}}
                      @setValue={{setValue}}
                    >
                      Personal
                    </DropdownMenuRadioItem>
                    <DropdownMenuRadioItem
                      @value="work"
                      @currentValue={{value}}
                      @setValue={{setValue}}
                    >
                      Work
                    </DropdownMenuRadioItem>
                    <DropdownMenuRadioItem
                      @value="other"
                      @currentValue={{value}}
                      @setValue={{setValue}}
                    >
                      Other
                    </DropdownMenuRadioItem>
                  </DropdownMenuRadioGroup>
                </DropdownMenuSubContent>
              </DropdownMenuSub>
            </DropdownMenuGroup>
            <DropdownMenuSeparator />
            <DropdownMenuGroup>
              <DropdownMenuItem
                @class="text-destructive focus:text-destructive"
              >
                <Trash2Icon />
                Trash
              </DropdownMenuItem>
            </DropdownMenuGroup>
          </DropdownMenuContent>
        </DropdownMenu>
      </ButtonGroup>
    </ButtonGroup>
  </template>
}
