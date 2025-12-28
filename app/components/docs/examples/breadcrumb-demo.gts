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
import { DropdownMenu } from '@/components/ui/dropdown-menu';

<template>
  <Breadcrumb>
    <BreadcrumbList>
      <BreadcrumbItem>
        <BreadcrumbLink @asChild={{true}}>
          <LinkTo @route="index">Home</LinkTo>
        </BreadcrumbLink>
      </BreadcrumbItem>
      <BreadcrumbSeparator />
      <BreadcrumbItem>
        <DropdownMenu as |dm|>
          <dm.Trigger @class="flex items-center gap-1">
            <BreadcrumbEllipsis class="size-4" />
            <span class="sr-only">Toggle menu</span>
          </dm.Trigger>
          <dm.Content as |c|>
            <c.Item>Documentation</c.Item>
            <c.Item>Themes</c.Item>
            <c.Item>GitHub</c.Item>
          </dm.Content>
        </DropdownMenu>
      </BreadcrumbItem>
      <BreadcrumbSeparator />
      <BreadcrumbItem>
        <BreadcrumbLink @asChild={{true}}>
          <LinkTo
            @route="docs.catch-all"
            @model="components"
          >Components</LinkTo>
        </BreadcrumbLink>
      </BreadcrumbItem>
      <BreadcrumbSeparator />
      <BreadcrumbItem>
        <BreadcrumbPage>Breadcrumb</BreadcrumbPage>
      </BreadcrumbItem>
    </BreadcrumbList>
  </Breadcrumb>
</template>
