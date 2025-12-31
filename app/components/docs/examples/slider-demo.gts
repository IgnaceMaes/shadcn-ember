import { Slider } from '@/components/ui/slider';
import { array } from '@ember/helper';

<template>
  <Slider
    @class="w-[60%]"
    @defaultValue={{array 50}}
    @max={{100}}
    @step={{1}}
  />
</template>
