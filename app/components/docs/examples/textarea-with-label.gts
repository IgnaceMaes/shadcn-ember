import { Label } from '@/components/ui/label';
import { Textarea } from '@/components/ui/textarea';

<template>
  <div class="grid w-full gap-3">
    <Label @for="message">Your message</Label>
    <Textarea placeholder="Type your message here." id="message" />
  </div>
</template>
