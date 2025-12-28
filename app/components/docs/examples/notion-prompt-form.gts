import { tracked } from '@glimmer/tracking';
import Component from '@glimmer/component';
import { fn } from '@ember/helper';
import { get } from '@ember/helper';
import { on } from '@ember/modifier';

import At from '~icons/lucide/at-sign';
import ArrowUp from '~icons/lucide/arrow-up';
import Paperclip from '~icons/lucide/paperclip';
import X from '~icons/lucide/x';
import Globe from '~icons/lucide/globe';
import Grid3x3 from '~icons/lucide/grid-3x3';
import BookOpen from '~icons/lucide/book-open';
import Plus from '~icons/lucide/plus';
import PlusCircle from '~icons/lucide/plus-circle';

import { Avatar, AvatarFallback, AvatarImage } from '@/components/ui/avatar';
import { Badge } from '@/components/ui/badge';
import {
  Command,
  CommandEmpty,
  CommandGroup,
  CommandInput,
  CommandItem,
  CommandList,
} from '@/components/ui/command';
import { DropdownMenu } from '@/components/ui/dropdown-menu';
import { Field, FieldLabel } from '@/components/ui/field';
import {
  InputGroup,
  InputGroupAddon,
  InputGroupButton,
  InputGroupTextarea,
} from '@/components/ui/input-group';
import { Popover } from '@/components/ui/popover';
import { Switch } from '@/components/ui/switch';
import { Tooltip } from '@/components/ui/tooltip';

const SAMPLE_DATA = {
  mentionable: [
    {
      type: 'page',
      title: 'Meeting Notes',
      image: '📝',
    },
    {
      type: 'page',
      title: 'Project Dashboard',
      image: '📊',
    },
    {
      type: 'page',
      title: 'Ideas & Brainstorming',
      image: '💡',
    },
    {
      type: 'page',
      title: 'Calendar & Events',
      image: '📅',
    },
    {
      type: 'page',
      title: 'Documentation',
      image: '📚',
    },
    {
      type: 'page',
      title: 'Goals & Objectives',
      image: '🎯',
    },
    {
      type: 'page',
      title: 'Budget Planning',
      image: '💰',
    },
    {
      type: 'page',
      title: 'Team Directory',
      image: '👥',
    },
    {
      type: 'page',
      title: 'Technical Specs',
      image: '🔧',
    },
    {
      type: 'page',
      title: 'Analytics Report',
      image: '📈',
    },
    {
      type: 'user',
      title: 'shadcn',
      image: 'https://github.com/shadcn.png',
      workspace: 'Workspace',
    },
    {
      type: 'user',
      title: 'maxleiter',
      image: 'https://github.com/maxleiter.png',
      workspace: 'Workspace',
    },
    {
      type: 'user',
      title: 'evilrabbit',
      image: 'https://github.com/evilrabbit.png',
      workspace: 'Workspace',
    },
  ],
  models: [
    {
      name: 'Auto',
    },
    {
      name: 'Agent Mode',
      badge: 'Beta',
    },
    {
      name: 'Plan Mode',
    },
  ],
};

type MentionableItem = (typeof SAMPLE_DATA.mentionable)[0];

class MentionableIcon extends Component<{ Args: { item: MentionableItem } }> {
  get isPage() {
    return this.args.item.type === 'page';
  }

  get fallback() {
    return this.args.item.title[0];
  }

  <template>
    {{#if this.isPage}}
      <span class="flex size-4 items-center justify-center">
        {{@item.image}}
      </span>
    {{else}}
      <Avatar @class="size-4">
        <AvatarImage @src={{@item.image}} />
        <AvatarFallback>{{this.fallback}}</AvatarFallback>
      </Avatar>
    {{/if}}
  </template>
}

class NotionPromptForm extends Component {
  @tracked mentions: string[] = [];
  @tracked mentionPopoverOpen = false;
  @tracked modelPopoverOpen = false;
  @tracked selectedModel = SAMPLE_DATA.models[0];
  @tracked scopeMenuOpen = false;

  get grouped() {
    return SAMPLE_DATA.mentionable.reduce(
      (acc, item) => {
        const isAvailable = !this.mentions.includes(item.title);

        if (isAvailable) {
          if (!acc[item.type]) {
            acc[item.type] = [];
          }
          acc[item.type]!.push(item);
        }
        return acc;
      },
      {} as Record<string, typeof SAMPLE_DATA.mentionable>
    );
  }

  get hasMentions() {
    return this.mentions.length > 0;
  }

  addMention = (mention: string) => {
    this.mentions = [...this.mentions, mention];
    this.mentionPopoverOpen = false;
  };

  removeMention = (mention: string) => {
    this.mentions = this.mentions.filter((m) => m !== mention);
  };

  selectModel = (model: (typeof SAMPLE_DATA.models)[0]) => {
    this.selectedModel = model;
  };

  handleSubmit = (event: SubmitEvent) => {
    event.preventDefault();
  };

  get mentionedItems() {
    return this.mentions
      .map((mention) =>
        SAMPLE_DATA.mentionable.find((item) => item.title === mention)
      )
      .filter((item): item is MentionableItem => item !== undefined);
  }

  get userItems() {
    return SAMPLE_DATA.mentionable.filter((item) => item.type === 'user');
  }

  stopPropagation = (e: Event) => {
    e.stopPropagation();
  };

  noop = () => {};

  getGroupHeading = (type: string) => {
    return type === 'page' ? 'Pages' : 'Users';
  };

  isModelSelected = (modelName: string) => {
    return modelName === this.selectedModel?.name;
  };

  <template>
    <form class="[--radius:1.2rem]" {{on "submit" this.handleSubmit}}>
      <Field>
        <FieldLabel @for="notion-prompt" @class="sr-only">
          Prompt
        </FieldLabel>
        <InputGroup>
          <InputGroupTextarea
            id="notion-prompt"
            placeholder="Ask, search, or make anything..."
          />
          <InputGroupAddon @align="block-start">
            <Popover as |p|>
              <Tooltip as |t|>
                <t.Trigger {{on "focusin" this.stopPropagation}}>
                  <p.Trigger>
                    <InputGroupButton
                      @variant="outline"
                      @size={{if this.hasMentions "icon-sm" "sm"}}
                      @class="rounded-full transition-transform"
                    >
                      <At />
                      {{#unless this.hasMentions}}Add context{{/unless}}
                    </InputGroupButton>
                  </p.Trigger>
                </t.Trigger>
                <t.Content>Mention a person, page, or date</t.Content>
              </Tooltip>
              <p.Content @class="p-0 [--radius:1.2rem]" @align="start">
                <Command>
                  <CommandInput placeholder="Search pages..." />
                  <CommandList>
                    <CommandEmpty>No pages found</CommandEmpty>
                    {{#each-in this.grouped as |type items|}}
                      <CommandGroup @heading={{this.getGroupHeading type}}>
                        {{#each items as |item|}}
                          <CommandItem
                            {{on "click" (fn this.addMention item.title)}}
                          >
                            <MentionableIcon @item={{item}} />
                            {{item.title}}
                          </CommandItem>
                        {{/each}}
                      </CommandGroup>
                    {{/each-in}}
                  </CommandList>
                </Command>
              </p.Content>
            </Popover>
            <div class="no-scrollbar -m-1.5 flex gap-1 overflow-y-auto p-1.5">
              {{#each this.mentionedItems as |item|}}
                <InputGroupButton
                  @size="sm"
                  @variant="secondary"
                  @class="rounded-full !pl-2"
                  {{on "click" (fn this.removeMention item.title)}}
                >
                  <MentionableIcon @item={{item}} />
                  {{item.title}}
                  <X />
                </InputGroupButton>
              {{/each}}
            </div>
          </InputGroupAddon>
          <InputGroupAddon @align="block-end" @class="gap-1">
            <Tooltip as |t|>
              <t.Trigger>
                <InputGroupButton
                  @size="icon-sm"
                  @class="rounded-full"
                  @variant="ghost"
                  aria-label="Attach file"
                >
                  <Paperclip />
                </InputGroupButton>
              </t.Trigger>
              <t.Content>Attach file</t.Content>
            </Tooltip>
            <DropdownMenu
              @open={{this.modelPopoverOpen}}
              @onOpenChange={{fn (mut this.modelPopoverOpen)}}
              as |d|
            >
              <Tooltip as |t|>
                <t.Trigger>
                  <d.Trigger>
                    <InputGroupButton
                      @size="sm"
                      @class="rounded-full"
                      @variant="ghost"
                    >
                      {{this.selectedModel.name}}
                    </InputGroupButton>
                  </d.Trigger>
                </t.Trigger>
                <t.Content>Select AI model</t.Content>
              </Tooltip>
              <d.Content @align="start" @class="[--radius:1rem]" as |c|>
                {{#each SAMPLE_DATA.models as |model|}}
                  <c.CheckboxItem
                    @checked={{this.isModelSelected model.name}}
                    @onCheckedChange={{fn this.selectModel model}}
                    @class="pl-2 *:[span:first-child]:right-2 *:[span:first-child]:left-auto"
                  >
                    {{model.name}}
                    {{#if model.badge}}
                      <Badge
                        @variant="secondary"
                        @class="h-5 rounded-sm bg-blue-100 px-1 text-xs text-blue-800 dark:bg-blue-900 dark:text-blue-100"
                      >
                        {{model.badge}}
                      </Badge>
                    {{/if}}
                  </c.CheckboxItem>
                {{/each}}
              </d.Content>
            </DropdownMenu>
            <DropdownMenu
              @open={{this.scopeMenuOpen}}
              @onOpenChange={{fn (mut this.scopeMenuOpen)}}
              as |d|
            >
              <d.Trigger>
                <InputGroupButton
                  @size="sm"
                  @class="rounded-full"
                  @variant="ghost"
                >
                  <Globe />
                  All Sources
                </InputGroupButton>
              </d.Trigger>
              <d.Content @align="end" @class="[--radius:1rem]" as |c|>
                <c.Group as |g|>
                  <g.Item
                    @onSelect={{this.noop}}
                    @asChild={{true}}
                    as |classes|
                  >
                    <label for="web-search" class={{classes}}>
                      <Globe />
                      Web Search
                      <Switch
                        id="web-search"
                        @class="ml-auto"
                        @checked={{true}}
                      />
                    </label>
                  </g.Item>
                </c.Group>
                <c.Item>
                  <Grid3x3 />
                  Apps and Integrations
                </c.Item>
                <c.Item>
                  <PlusCircle />
                  All Sources I can access
                </c.Item>
                <c.Group as |g|>
                  <g.Sub as |sub|>
                    <sub.Trigger>
                      <Avatar @class="size-4">
                        <AvatarImage @src="https://github.com/shadcn.png" />
                        <AvatarFallback>CN</AvatarFallback>
                      </Avatar>
                      shadcn
                    </sub.Trigger>
                    <sub.Content @class="w-72 p-0 [--radius:1rem]">
                      <Command>
                        <CommandInput
                          placeholder="Find or use knowledge in..."
                        />
                        <CommandList>
                          <CommandEmpty>No knowledge found</CommandEmpty>
                          <CommandGroup>
                            {{#each this.userItems as |user|}}
                              <CommandItem>
                                <Avatar @class="size-4">
                                  <AvatarImage @src={{user.image}} />
                                  <AvatarFallback>{{get
                                      user.title
                                      0
                                    }}</AvatarFallback>
                                </Avatar>
                                {{user.title}}
                                <span class="text-muted-foreground">
                                  -
                                  {{user.workspace}}
                                </span>
                              </CommandItem>
                            {{/each}}
                          </CommandGroup>
                        </CommandList>
                      </Command>
                    </sub.Content>
                  </g.Sub>
                  <g.Item>
                    <BookOpen />
                    Help Center
                  </g.Item>
                </c.Group>
                <c.Group as |g|>
                  <g.Item>
                    <Plus />
                    Connect Apps
                  </g.Item>
                  <g.Label @class="text-muted-foreground text-xs">
                    We'll only search in the sources selected here.
                  </g.Label>
                </c.Group>
              </d.Content>
            </DropdownMenu>
            <InputGroupButton
              aria-label="Send"
              @class="ml-auto rounded-full"
              @variant="default"
              @size="icon-sm"
            >
              <ArrowUp />
            </InputGroupButton>
          </InputGroupAddon>
        </InputGroup>
      </Field>
    </form>
  </template>
}

export default NotionPromptForm;
