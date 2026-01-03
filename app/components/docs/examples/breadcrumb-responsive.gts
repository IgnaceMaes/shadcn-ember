import { LinkTo } from '@ember/routing';

import {
  Breadcrumb,
  BreadcrumbEllipsis,
  BreadcrumbItem,
  BreadcrumbLink,
  BreadcrumbList,
  BreadcrumbPage,
  BreadcrumbSeparator,
} from '@/components/ui/breadcrumb';
import {
  DropdownMenu,
  DropdownMenuContent,
  DropdownMenuItem,
  DropdownMenuTrigger,
} from '@/components/ui/dropdown-menu';

<template>
  <Breadcrumb>
    <BreadcrumbList>
      <BreadcrumbItem>
        <BreadcrumbLink @asChild={{true}} as |classes|>
          <LinkTo @route="index" class={{classes}}>Home</LinkTo>
        </BreadcrumbLink>
      </BreadcrumbItem>
      <BreadcrumbSeparator />
      <BreadcrumbItem class="hidden md:block">
        <BreadcrumbLink @asChild={{true}} as |classes|>
          <LinkTo @route="docs" class={{classes}}>Documentation</LinkTo>
        </BreadcrumbLink>
      </BreadcrumbItem>
      <BreadcrumbSeparator class="hidden md:block" />
      <BreadcrumbItem class="hidden md:block">
        <BreadcrumbLink @asChild={{true}} as |classes|>
          <LinkTo
            @model="components"
            @route="docs.catch-all"
            class={{classes}}
          >Components</LinkTo>
        </BreadcrumbLink>
      </BreadcrumbItem>
      <BreadcrumbSeparator class="hidden md:block" />
      <BreadcrumbItem class="md:hidden">
        <DropdownMenu>
          <DropdownMenuTrigger @class="flex items-center gap-1">
            <BreadcrumbEllipsis class="size-4" />
            <span class="sr-only">Toggle menu</span>
          </DropdownMenuTrigger>
          <DropdownMenuContent>
            <DropdownMenuItem>Documentation</DropdownMenuItem>
            <DropdownMenuItem>Components</DropdownMenuItem>
            <DropdownMenuItem>Breadcrumb</DropdownMenuItem>
          </DropdownMenuContent>
        </DropdownMenu>
      </BreadcrumbItem>
      <BreadcrumbSeparator class="md:hidden" />
      <BreadcrumbItem>
        <BreadcrumbPage>Breadcrumb</BreadcrumbPage>
      </BreadcrumbItem>
    </BreadcrumbList>
  </Breadcrumb>
</template>
