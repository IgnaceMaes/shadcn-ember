import { tracked } from '@glimmer/tracking';
import { on } from '@ember/modifier';
import DocLinkTo from '@/components/docs/doc-link-to';

// Icons
import ChevronRight from '~icons/lucide/chevron-right';
import Check from '~icons/lucide/check';
import Copy from '~icons/lucide/copy';
import UserPlus from '~icons/lucide/user-plus';

// UI Components
import Button from '@/components/ui/button';
import Badge from '@/components/ui/badge';
import Input from '@/components/ui/input';
import Textarea from '@/components/ui/textarea';
import Label from '@/components/ui/label';
import Separator from '@/components/ui/separator';
import Switch from '@/components/ui/switch';
import Checkbox from '@/components/ui/checkbox';
import { Slider } from '@/components/ui/slider';
import { Progress } from '@/components/ui/progress';
import {
  Card,
  CardContent,
  CardDescription,
  CardFooter,
  CardHeader,
  CardTitle,
} from '@/components/ui/card';
import { Avatar, AvatarImage, AvatarFallback } from '@/components/ui/avatar';
import {
  Select,
  SelectTrigger,
  SelectValue,
  SelectContent,
  SelectGroup,
  SelectItem,
  SelectLabel,
} from '@/components/ui/select';
import FieldDemo from '@/components/docs/examples/field-demo';

// State management class for the homepage
class HomepageState {
  @tracked email = '';
  @tracked sliderValue = [33];
  @tracked progressValue = 60;
  @tracked switchChecked = false;
  @tracked checkboxChecked = false;
  @tracked selectedFramework = '';
  @tracked copied = false;

  get sliderDisplayValue(): number {
    return this.sliderValue[0] ?? 0;
  }

  updateEmail = (event: Event) => {
    this.email = (event.target as HTMLInputElement).value;
  };

  updateSlider = (value: number[]) => {
    this.sliderValue = value;
  };

  toggleSwitch = (checked: boolean) => {
    this.switchChecked = checked;
  };

  toggleCheckbox = (checked: boolean) => {
    this.checkboxChecked = checked;
  };

  selectFramework = (value: string) => {
    this.selectedFramework = value;
  };

  copyToClipboard = async () => {
    await navigator.clipboard.writeText('npx shadcn-ember@latest init');
    this.copied = true;
    setTimeout(() => {
      this.copied = false;
    }, 2000);
  };
}

const state = new HomepageState();

<template>
  <div class="min-h-screen bg-background">
    <main>
      {{! Hero Section }}
      <section class="relative">
        <div class="container relative px-4 mx-auto">
          <div
            class="container flex flex-col items-center gap-2 py-8 text-center md:py-16 lg:py-20 xl:gap-4"
          >
            <DocLinkTo @route="docs.changelog">
              <Badge @variant="secondary" class="rounded-full px-4 py-1.5">
                <span class="mr-2">🎉</span>
                shadcn/ui for Ember.js
                <ChevronRight class="ml-1 h-3.5 w-3.5" />
              </Badge>
            </DocLinkTo>
            <h1
              class="text-primary leading-tighter text-4xl font-semibold tracking-tight text-balance lg:leading-[1.1] lg:font-semibold xl:text-5xl xl:tracking-tight max-w-4xl"
            >
              The Foundation for your Design System
            </h1>
            <p
              class="text-foreground max-w-3xl text-base text-balance sm:text-lg"
            >
              A set of beautifully designed components that you can customize,
              extend, and build on. Start here then make it your own. Open
              Source. Open Code.
            </p>
            <div class="flex flex-wrap items-center justify-center gap-4 pt-4">
              <DocLinkTo @route="docs">
                <Button>
                  Get Started
                </Button>
              </DocLinkTo>
              <DocLinkTo @route="docs.components">
                <Button @variant="ghost">
                  View Components
                </Button>
              </DocLinkTo>
            </div>
          </div>
        </div>
      </section>

      {{! Component Examples }}
      <section class="container-wrapper section-soft flex-1 pb-6">
        <div class="container mx-auto px-4">
          {{! Masonry layout - manually balanced columns }}
          <div
            class="theme-container mx-auto grid gap-8 py-1 md:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 xl:gap-6 2xl:gap-8"
          >

            {{! Column 1 }}
            <div class="flex flex-col gap-6 *:[div]:w-full *:[div]:max-w-full">
              {{! Field Demo }}
              <FieldDemo />

              {{! Input with Label }}
              <Card>
                <CardHeader>
                  <CardTitle>Text Input</CardTitle>
                  <CardDescription>A simple text input with label.</CardDescription>
                </CardHeader>
                <CardContent class="grid gap-4">
                  <div class="grid gap-2">
                    <Label @for="email">Email</Label>
                    <Input
                      type="email"
                      id="email"
                      placeholder="your@email.com"
                      value={{state.email}}
                      {{on "input" state.updateEmail}}
                    />
                  </div>
                </CardContent>
              </Card>

              {{! Slider }}
              <Card>
                <CardHeader>
                  <CardTitle>Slider</CardTitle>
                  <CardDescription>A range slider control.</CardDescription>
                </CardHeader>
                <CardContent class="grid gap-4">
                  <div class="grid gap-2">
                    <div class="flex justify-between">
                      <Label>Volume</Label>
                      <span
                        class="text-sm text-muted-foreground"
                      >{{state.sliderDisplayValue}}%</span>
                    </div>
                    <Slider
                      @defaultValue={{state.sliderValue}}
                      @onValueChange={{state.updateSlider}}
                      @max={{100}}
                      @step={{1}}
                    />
                  </div>
                </CardContent>
              </Card>

              {{! Input }}
              <Card>
                <CardHeader>
                  <CardTitle>Input</CardTitle>
                  <CardDescription>Text input field.</CardDescription>
                </CardHeader>
                <CardContent>
                  <Input placeholder="Type here..." />
                </CardContent>
              </Card>

              {{! Progress }}
              <Card>
                <CardHeader>
                  <CardTitle>Progress</CardTitle>
                  <CardDescription>Loading state.</CardDescription>
                </CardHeader>
                <CardContent>
                  <Progress @value={{state.progressValue}} />
                </CardContent>
              </Card>
            </div>

            {{! Column 2 }}
            <div class="flex flex-col gap-6 *:[div]:w-full *:[div]:max-w-full">
              {{! Team Members Card }}
              <Card>
                <CardHeader>
                  <CardTitle>Team Members</CardTitle>
                  <CardDescription>Invite your team to collaborate.</CardDescription>
                </CardHeader>
                <CardContent class="grid gap-4">
                  <div class="flex items-center gap-4">
                    <Avatar>
                      <AvatarImage
                        @src="https://github.com/IgnaceMaes.png"
                        @alt="Ignace"
                      />
                      <AvatarFallback>IB</AvatarFallback>
                    </Avatar>
                    <div class="flex-1">
                      <p class="text-sm font-medium">Ignace Maes</p>
                      <p class="text-sm text-muted-foreground">Owner</p>
                    </div>
                    <Badge @variant="secondary">Admin</Badge>
                  </div>
                  <div class="flex items-center gap-4">
                    <Avatar>
                      <AvatarFallback>EM</AvatarFallback>
                    </Avatar>
                    <div class="flex-1">
                      <p class="text-sm font-medium">Ember Developer</p>
                      <p class="text-sm text-muted-foreground">Developer</p>
                    </div>
                    <Badge @variant="outline">Member</Badge>
                  </div>
                </CardContent>
                <CardFooter>
                  <Button @variant="outline" class="w-full">
                    <UserPlus class="mr-2 h-4 w-4" />
                    Invite Member
                  </Button>
                </CardFooter>
              </Card>

              {{! Badges }}
              <Card>
                <CardHeader>
                  <CardTitle>Badges</CardTitle>
                  <CardDescription>Status and labels.</CardDescription>
                </CardHeader>
                <CardContent class="flex flex-wrap gap-2">
                  <Badge>Default</Badge>
                  <Badge @variant="secondary">Secondary</Badge>
                  <Badge @variant="destructive">Destructive</Badge>
                  <Badge @variant="outline">Outline</Badge>
                </CardContent>
              </Card>

              {{! Buttons }}
              <Card>
                <CardHeader>
                  <CardTitle>Buttons</CardTitle>
                  <CardDescription>Button variants.</CardDescription>
                </CardHeader>
                <CardContent class="grid gap-3">
                  <div class="flex flex-wrap gap-2">
                    <Button>Default</Button>
                    <Button @variant="secondary">Secondary</Button>
                    <Button @variant="outline">Outline</Button>
                  </div>
                  <div class="flex flex-wrap gap-2">
                    <Button @variant="ghost">Ghost</Button>
                    <Button @variant="link">Link</Button>
                    <Button @variant="destructive">Destructive</Button>
                  </div>
                </CardContent>
              </Card>
            </div>

            {{! Column 3 }}
            <div class="flex flex-col gap-6 *:[div]:w-full *:[div]:max-w-full">
              {{! Input with Button }}
              <Card>
                <CardHeader>
                  <CardTitle>Input Button</CardTitle>
                  <CardDescription>Input with an action button.</CardDescription>
                </CardHeader>
                <CardContent class="flex gap-2">
                  <Input placeholder="Enter command..." class="flex-1" />
                  <Button @size="icon">
                    <Copy class="h-4 w-4" />
                  </Button>
                </CardContent>
              </Card>

              {{! Item Demo }}
              <Card>
                <CardHeader>
                  <CardTitle>Items</CardTitle>
                  <CardDescription>List with actions.</CardDescription>
                </CardHeader>
                <CardContent>
                  <div class="flex items-center justify-between">
                    <div class="flex items-center gap-2">
                      <Avatar @size="sm">
                        <AvatarFallback>EC</AvatarFallback>
                      </Avatar>
                      <div>
                        <p class="text-sm font-medium">ember-cli</p>
                        <p class="text-xs text-muted-foreground">Build tool</p>
                      </div>
                    </div>
                    <Button @variant="ghost" @size="sm">View</Button>
                  </div>
                </CardContent>
              </Card>

              {{! Separator }}
              <div class="py-4">
                <Separator />
                <p
                  class="text-center text-sm text-muted-foreground my-4"
                >Appearance Settings</p>
                <Separator />
              </div>

              {{! Appearance }}
              <Card>
                <CardHeader>
                  <CardTitle>Appearance</CardTitle>
                  <CardDescription>Customize your experience.</CardDescription>
                </CardHeader>
                <CardContent class="grid gap-4">
                  <div class="flex items-center justify-between">
                    <Label @for="dark-mode">Dark Mode</Label>
                    <Switch id="dark-mode" />
                  </div>
                  <div class="flex items-center justify-between">
                    <Label @for="notifications">Notifications</Label>
                    <Switch
                      id="notifications"
                      @checked={{state.switchChecked}}
                      @onCheckedChange={{state.toggleSwitch}}
                    />
                  </div>
                </CardContent>
              </Card>
            </div>

            {{! Column 4 }}
            <div class="flex flex-col gap-6 *:[div]:w-full *:[div]:max-w-full">
              {{! Create Project Form }}
              <Card>
                <CardHeader>
                  <CardTitle>Create Project</CardTitle>
                  <CardDescription>Deploy in one-click.</CardDescription>
                </CardHeader>
                <CardContent class="grid gap-4">
                  <div class="grid gap-2">
                    <Label @for="name">Name</Label>
                    <Input type="text" id="name" placeholder="my-ember-app" />
                  </div>
                  <div class="grid gap-2">
                    <Label @for="description">Description</Label>
                    <Textarea
                      id="description"
                      placeholder="Project description..."
                    />
                  </div>
                </CardContent>
                <CardFooter class="justify-between">
                  <Button @variant="outline">Cancel</Button>
                  <Button>Deploy</Button>
                </CardFooter>
              </Card>

              {{! Button Group Demo }}
              <Card>
                <CardHeader>
                  <CardTitle>Button Group</CardTitle>
                  <CardDescription>Grouped actions.</CardDescription>
                </CardHeader>
                <CardContent class="flex gap-2">
                  <Button @variant="outline" @size="sm">Previous</Button>
                  <Button @variant="outline" @size="sm">1</Button>
                  <Button @variant="outline" @size="sm">2</Button>
                  <Button @variant="outline" @size="sm">3</Button>
                  <Button @variant="outline" @size="sm">Next</Button>
                </CardContent>
              </Card>

              {{! Checkbox }}
              <Card>
                <CardHeader>
                  <CardTitle>Checkbox</CardTitle>
                  <CardDescription>Toggle options.</CardDescription>
                </CardHeader>
                <CardContent class="grid gap-4">
                  <div class="flex items-center space-x-2">
                    <Checkbox
                      id="terms"
                      @checked={{state.checkboxChecked}}
                      @onCheckedChange={{state.toggleCheckbox}}
                    />
                    <Label @for="terms">Accept terms</Label>
                  </div>
                  <div class="flex items-center space-x-2">
                    <Checkbox id="marketing" />
                    <Label @for="marketing">Marketing emails</Label>
                  </div>
                </CardContent>
              </Card>

              {{! Nested Button Groups }}
              <div class="flex justify-between gap-4">
                <Card class="flex-1">
                  <CardContent class="pt-6">
                    <div class="flex gap-1">
                      <Button @variant="outline" @size="sm">
                        <Copy class="h-4 w-4" />
                      </Button>
                      <Button @variant="outline" @size="sm">
                        <Check class="h-4 w-4" />
                      </Button>
                    </div>
                  </CardContent>
                </Card>
                <Card class="flex-1">
                  <CardContent class="pt-6">
                    <Button @variant="outline" @size="sm" class="w-full">
                      Actions
                    </Button>
                  </CardContent>
                </Card>
              </div>

              {{! Select Demo }}
              <Card>
                <CardHeader>
                  <CardTitle>Select</CardTitle>
                  <CardDescription>Choose an option.</CardDescription>
                </CardHeader>
                <CardContent>
                  <Select @onValueChange={{state.selectFramework}} as |select|>
                    <SelectTrigger @toggle={{select.toggle}}>
                      <SelectValue @placeholder="Select framework">
                        {{#if state.selectedFramework}}
                          {{state.selectedFramework}}
                        {{/if}}
                      </SelectValue>
                    </SelectTrigger>
                    <SelectContent @isOpen={{select.isOpen}}>
                      <SelectGroup>
                        <SelectLabel>Frameworks</SelectLabel>
                        <SelectItem
                          @value="Ember.js"
                          @onSelect={{select.selectValue}}
                        >Ember.js</SelectItem>
                        <SelectItem
                          @value="React"
                          @onSelect={{select.selectValue}}
                        >React</SelectItem>
                        <SelectItem
                          @value="Vue"
                          @onSelect={{select.selectValue}}
                        >Vue</SelectItem>
                      </SelectGroup>
                    </SelectContent>
                  </Select>
                </CardContent>
              </Card>
            </div>

          </div>
        </div>
      </section>
    </main>

    {{! Footer }}
    <footer class="border-t py-6 md:py-0">
      <div
        class="container flex flex-col items-center justify-between gap-4 md:h-16 md:flex-row px-4 mx-auto"
      >
        <p
          class="text-balance text-center text-sm leading-loose text-muted-foreground md:text-left"
        >
          Built by
          <a
            href="https://github.com/IgnaceMaes"
            target="_blank"
            rel="noopener noreferrer"
            class="font-medium underline underline-offset-4"
          >
            Ignace Maes
          </a>. The source code is available on
          <a
            href="https://github.com/IgnaceMaes/shadcn-ember"
            target="_blank"
            rel="noopener noreferrer"
            class="font-medium underline underline-offset-4"
          >
            GitHub
          </a>.
        </p>
      </div>
    </footer>
  </div>
</template>
