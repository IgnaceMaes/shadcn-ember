import Check from '~icons/lucide/check';
import CreditCard from '~icons/lucide/credit-card';
import Info from '~icons/lucide/info';
import Mail from '~icons/lucide/mail';
import Search from '~icons/lucide/search';
import Star from '~icons/lucide/star';
import {
  InputGroup,
  InputGroupAddon,
  InputGroupInput,
} from '@/components/ui/input-group';

<template>
  <div class="grid w-full max-w-sm gap-6">
    <InputGroup>
      <InputGroupInput placeholder="Search..." />
      <InputGroupAddon>
        <Search />
      </InputGroupAddon>
    </InputGroup>

    <InputGroup>
      <InputGroupInput type="email" placeholder="Enter your email" />
      <InputGroupAddon>
        <Mail />
      </InputGroupAddon>
    </InputGroup>

    <InputGroup>
      <InputGroupInput placeholder="Card number" />
      <InputGroupAddon>
        <CreditCard />
      </InputGroupAddon>
      <InputGroupAddon @align="inline-end">
        <Check />
      </InputGroupAddon>
    </InputGroup>

    <InputGroup>
      <InputGroupInput placeholder="Card number" />
      <InputGroupAddon @align="inline-end">
        <Star />
        <Info />
      </InputGroupAddon>
    </InputGroup>
  </div>
</template>
