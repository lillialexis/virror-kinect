enum EMPrimary {
  NORMAL,
  INVERT,
  //GRAY,
  EFFECT_MODE_PRIMARY_COUNT;
};

enum EMSecondary {
  NONE,
  COLOR,
  EFFECT_MODE_SECONDARY_COUNT
};

EMPrimary primary = EMPrimary.NORMAL;
EMSecondary secondary = EMSecondary.NONE;

int pmFrameCounter = 0;
int smFrameCounter = 0;

int pmFrameTimeout = 100;
int smFrameTimeout = 100;

void checkUpdatePrimary() {
  if (pmFrameCounter == pmFrameTimeout) {
    flop1();
    pmFrameCounter = 0;

    primary = EMPrimary.values()[(primary.ordinal() + 1) 
                   % EMPrimary.EFFECT_MODE_PRIMARY_COUNT.ordinal()];
  } else {
    pmFrameCounter++; 
  }
}

void checkUpdateSecondary() {
  if (smFrameCounter == smFrameTimeout) {
    flop2();
    smFrameCounter = 0;

    secondary = EMSecondary.values()[(secondary.ordinal() + 1) 
                   % EMSecondary.EFFECT_MODE_SECONDARY_COUNT.ordinal()];
  } else {
    smFrameCounter++; 
  }
}

void castEffect(PImage frame) {
  checkUpdatePrimary();
  checkUpdateSecondary();

  switch (primary) {
     case NORMAL: 
       break;
     case INVERT:
         frame.filter(INVERT);
       break;
     default:
       break;
  }

  switch (secondary) {
     case NONE: 
       break;
     case COLOR:
       break;
     default:
       break;
  }
}
