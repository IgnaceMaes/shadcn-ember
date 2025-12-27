import { Label } from '@/components/ui/label';
import { Textarea } from '@/components/ui/textarea';

<template>
  <div class="grid w-full gap-3">
    <Label @for="message-2">Your Message</Label>
    <Textarea placeholder="Type your message here." id="message-2" />
    <p class="text-muted-foreground text-sm">
      Your message will be copied to the support team.
    </p>
  </div>
</template>
