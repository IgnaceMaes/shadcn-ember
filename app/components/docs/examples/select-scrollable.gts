import {
  Select,
  SelectGroup,
  SelectLabel,
} from '@/components/ui/select';

<template>
  <Select as |s|>
    <s.Trigger @class="w-[280px]">
      <s.Value @placeholder="Select a timezone" />
    </s.Trigger>
    <s.Content as |c|>
      <SelectGroup>
        <SelectLabel>North America</SelectLabel>
        <c.Item @value="est">Eastern Standard Time (EST)</c.Item>
        <c.Item @value="cst">Central Standard Time (CST)</c.Item>
        <c.Item @value="mst">Mountain Standard Time (MST)</c.Item>
        <c.Item @value="pst">Pacific Standard Time (PST)</c.Item>
        <c.Item @value="akst">Alaska Standard Time (AKST)</c.Item>
        <c.Item @value="hst">Hawaii Standard Time (HST)</c.Item>
      </SelectGroup>
      <SelectGroup>
        <SelectLabel>Europe & Africa</SelectLabel>
        <c.Item @value="gmt">Greenwich Mean Time (GMT)</c.Item>
        <c.Item @value="cet">Central European Time (CET)</c.Item>
        <c.Item @value="eet">Eastern European Time (EET)</c.Item>
        <c.Item @value="west">Western European Summer Time (WEST)</c.Item>
        <c.Item @value="cat">Central Africa Time (CAT)</c.Item>
        <c.Item @value="eat">East Africa Time (EAT)</c.Item>
      </SelectGroup>
      <SelectGroup>
        <SelectLabel>Asia</SelectLabel>
        <c.Item @value="msk">Moscow Time (MSK)</c.Item>
        <c.Item @value="ist">India Standard Time (IST)</c.Item>
        <c.Item @value="cst_china">China Standard Time (CST)</c.Item>
        <c.Item @value="jst">Japan Standard Time (JST)</c.Item>
        <c.Item @value="kst">Korea Standard Time (KST)</c.Item>
        <c.Item @value="ist_indonesia">Indonesia Central Standard Time (WITA)</c.Item>
      </SelectGroup>
      <SelectGroup>
        <SelectLabel>Australia & Pacific</SelectLabel>
        <c.Item @value="awst">Australian Western Standard Time (AWST)</c.Item>
        <c.Item @value="acst">Australian Central Standard Time (ACST)</c.Item>
        <c.Item @value="aest">Australian Eastern Standard Time (AEST)</c.Item>
        <c.Item @value="nzst">New Zealand Standard Time (NZST)</c.Item>
        <c.Item @value="fjt">Fiji Time (FJT)</c.Item>
      </SelectGroup>
      <SelectGroup>
        <SelectLabel>South America</SelectLabel>
        <c.Item @value="art">Argentina Time (ART)</c.Item>
        <c.Item @value="bot">Bolivia Time (BOT)</c.Item>
        <c.Item @value="brt">Brasilia Time (BRT)</c.Item>
        <c.Item @value="clt">Chile Standard Time (CLT)</c.Item>
      </SelectGroup>
    </s.Content>
  </Select>
</template>
