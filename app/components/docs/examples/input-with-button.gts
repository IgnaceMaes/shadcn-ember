import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';

<template>
  <div class="flex w-full max-w-sm items-center gap-2">
    <Input type="email" placeholder="Email" />
    <Button type="submit" @variant="outline">Subscribe</Button>
  </div>
</template>
