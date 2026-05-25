import { Calendar } from '@/components/ui/calendar';

<template>
  <Calendar
    @class="rounded-lg border"
    @mode="single"
    @showWeekNumber={{true}}
  />
</template>
