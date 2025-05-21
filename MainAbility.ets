import UIAbility from '@ohos.app.ability.UIAbility';
import AbilityConstant from '@ohos.app.ability.AbilityConstant';
import type { Configuration } from '@ohos.app.ability.Configuration';
import hilog from '@ohos.hilog';
import window from '@ohos.window';
import Want from '@ohos.app.ability.Want';
import { PAGES } from '../common/constants';

const TAG: string = '[MainAbility]';
const DOMAIN: number = 0x0000;

export default class MainAbility extends UIAbility {
  private windowStage_: window.WindowStage | null = null;
  private currentPageUrl: string = PAGES.SPLASH;

  onCreate(want: Want, launchParam: AbilityConstant.LaunchParam) {
    hilog.info(DOMAIN, TAG, '%{public}s', 'Ability onCreate');
    
    // 获取启动参数
    const params = want.parameters;
    if (params) {
      hilog.info(DOMAIN, TAG, 'want params: %{public}s', JSON.stringify(params));
      // 如果有指定页面参数，更新当前页面URL
      if (params.pageUrl) {
        const targetPage = params.pageUrl as string;
        if (Object.values(PAGES).includes(targetPage)) {
          this.currentPageUrl = targetPage;
        }
      }
    }
  }

  onDestroy() {
    hilog.info(DOMAIN, TAG, '%{public}s', 'Ability onDestroy');
    // 清理资源
    this.windowStage_ = null;
  }

  onWindowStageCreate(windowStage: window.WindowStage) {
    hilog.info(DOMAIN, TAG, '%{public}s', 'Ability onWindowStageCreate');
    this.windowStage_ = windowStage;
    
    // 设置窗口属性
    windowStage.getMainWindow((err: Error, windowClass: window.Window) => {
      if (err) {
        hilog.error(DOMAIN, TAG, 'Failed to get the main window. Cause: %{public}s', JSON.stringify(err));
        return;
      }
      
      // 设置窗口为全屏显示
      windowClass.setWindowSystemBarEnable(['navigation'])
        .then(() => {
          hilog.info(DOMAIN, TAG, 'Succeeded in setting system bar.');
        })
        .catch((err: Error) => {
          hilog.error(DOMAIN, TAG, 'Failed to set system bar. Cause: %{public}s', err.message);
        });

      // 设置窗口保持常亮
      windowClass.setWindowKeepScreenOn(true)
        .then(() => {
          hilog.info(DOMAIN, TAG, 'Succeeded in setting keep screen on.');
        })
        .catch((err: Error) => {
          hilog.error(DOMAIN, TAG, 'Failed to set keep screen on. Cause: %{public}s', err.message);
        });
    });

    // 加载启动页
    windowStage.loadContent(PAGES.SPLASH, (err: Error) => {
      if (err) {
        hilog.error(DOMAIN, TAG, 'Failed to load the content. Cause: %{public}s', JSON.stringify(err));
        return;
      }
      hilog.info(DOMAIN, TAG, 'Succeeded in loading the splash page');
    });
  }

  onWindowStageDestroy() {
    hilog.info(DOMAIN, TAG, '%{public}s', 'Ability onWindowStageDestroy');
    this.windowStage_ = null;
  }

  onForeground() {
    hilog.info(DOMAIN, TAG, '%{public}s', 'Ability onForeground');
    // 恢复页面状态
    if (this.windowStage_) {
      this.windowStage_.getMainWindow((err: Error, windowClass: window.Window) => {
        if (err) {
          return;
        }
        windowClass.setWindowKeepScreenOn(true);
      });
    }
  }

  onBackground() {
    hilog.info(DOMAIN, TAG, '%{public}s', 'Ability onBackground');
    // 保存页面状态
    if (this.windowStage_) {
      this.windowStage_.getMainWindow((err: Error, windowClass: window.Window) => {
        if (err) {
          return;
        }
        windowClass.setWindowKeepScreenOn(false);
      });
    }
  }

  onNewWant(want: Want) {
    hilog.info(DOMAIN, TAG, '%{public}s', 'Ability onNewWant');
    // 处理新的启动参数
    const params = want.parameters;
    if (params && params.pageUrl) {
      const targetPage = params.pageUrl as string;
      if (Object.values(PAGES).includes(targetPage)) {
        this.currentPageUrl = targetPage;
        if (this.windowStage_) {
          this.windowStage_.loadContent(this.currentPageUrl, (err: Error) => {
            if (err) {
              hilog.error(DOMAIN, TAG, 'Failed to load new content. Cause: %{public}s', JSON.stringify(err));
            }
          });
        }
      }
    }
  }

  onConfigurationUpdate(config: Configuration) {
    hilog.info(DOMAIN, TAG, '%{public}s', 'Ability onConfigurationUpdate');
  }
}