enum EMPrimary {
  NORMAL,
  INVERT,
  //GRAY,
  // TODO: Add new modes here
  EFFECT_MODE_PRIMARY_COUNT;
};

enum EMSecondary {
  NONE,
  COLOR,
  // TODO: Add new modes here
  EFFECT_MODE_SECONDARY_COUNT
};

EMPrimary primary = EMPrimary.NORMAL;
EMSecondary secondary = EMSecondary.NONE;

int pmFrameCounter = 0;
int smFrameCounter = 0;

int pmFrameTimeout = 60 * 30;
int smFrameTimeout = 60 * 30;

void checkUpdatePrimary() {
  if (pmFrameCounter == pmFrameTimeout) {
    pmFrameCounter = 0;

    primary = EMPrimary.values()[(primary.ordinal() + 1) 
                   % EMPrimary.EFFECT_MODE_PRIMARY_COUNT.ordinal()];

    // Modes last between 20 and 120 seconds.
    pmFrameTimeout = int(random(20, 120)) * 60;

  } else {
    pmFrameCounter++; 
  }
}

void checkUpdateSecondary() {
  if (smFrameCounter == smFrameTimeout) {
    smFrameCounter = 0;

    secondary = EMSecondary.values()[(secondary.ordinal() + 1) 
                   % EMSecondary.EFFECT_MODE_SECONDARY_COUNT.ordinal()];

    // Modes last between 20 and 120 seconds.
    smFrameTimeout = int(random(20, 120)) * 60;

  } else {
    smFrameCounter++; 
  }
}

void castEffect(PImage frame) {
  checkUpdatePrimary();
  checkUpdateSecondary();

  // TODO: Call new modes here
  switch (primary) {
     case NORMAL: 
       break;
     case INVERT:
         // TODO: Inverting is boring. Uncomment if you want to do it.
         //frame.filter(INVERT);
       break;
     default:
       break;
  }

  // TODO: Call new modes here
  switch (secondary) {
     case NONE: 
       break;
     case COLOR:
       break;
     default:
       break;
  }
}
