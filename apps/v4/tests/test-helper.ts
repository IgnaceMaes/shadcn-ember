import { setApplication } from '@ember/test-helpers';
import { start as qunitStart, setupEmberOnerrorValidation } from 'ember-qunit';
import * as QUnit from 'qunit';
import { setup } from 'qunit-dom';

import Application from 'shadcn-ember-docs/app';
import config from 'shadcn-ember-docs/config/environment';

export function start() {
  setApplication(Application.create(config.APP));

  setup(QUnit.assert);
  setupEmberOnerrorValidation();

  qunitStart();
}
