import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import { Button } from '@/components/ui/button';
import { ButtonGroup } from '@/components/ui/button-group';
import {
  DropdownMenu,
  DropdownMenuRadioItem,
  DropdownMenuSeparator,
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
        <DropdownMenu as |dm|>
          <dm.Trigger @asChild={{true}}>
            <Button @variant="outline" @size="icon" aria-label="More Options">
              <MoreHorizontalIcon />
            </Button>
          </dm.Trigger>
          <dm.Content @class="w-52" as |c|>
            <c.Group as |g|>
              <g.Item>
                <MailCheckIcon />
                Mark as Read
              </g.Item>
              <g.Item>
                <ArchiveIcon />
                Archive
              </g.Item>
            </c.Group>
            <DropdownMenuSeparator />
            <c.Group as |g|>
              <g.Item>
                <ClockIcon />
                Snooze
              </g.Item>
              <g.Item>
                <CalendarPlusIcon />
                Add to Calendar
              </g.Item>
              <g.Item>
                <ListFilterIcon />
                Add to List
              </g.Item>
              <g.Sub as |sub|>
                <sub.Trigger>
                  <TagIcon />
                  Label As...
                </sub.Trigger>
                <sub.Content>
                  <c.RadioGroup
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
                  </c.RadioGroup>
                </sub.Content>
              </g.Sub>
            </c.Group>
            <DropdownMenuSeparator />
            <c.Group as |g|>
              <g.Item @class="text-destructive focus:text-destructive">
                <Trash2Icon />
                Trash
              </g.Item>
            </c.Group>
          </dm.Content>
        </DropdownMenu>
      </ButtonGroup>
    </ButtonGroup>
  </template>
}
