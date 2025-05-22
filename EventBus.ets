import { ReminderItem } from './CalendarConstants';
import { ShowDetailPayload } from './ShowDetailTypes';

// 定义事件名称类型
type EventName = string;

// 定义监听器类型
type AddReminderListener = (date: string) => void;
type ReminderSavedListener = (reminder: ReminderItem) => void;
type ShowDetailListener = (payload: ShowDetailPayload) => void;

// 事件常量类型
interface EventsType {
  ADD_REMINDER: string;
  REMINDER_SAVED: string;
  SHOW_DETAIL: string;
}

// 存储不同类型监听器的接口
interface ListenerStore {
  ADD_REMINDER?: AddReminderListener[];
  REMINDER_SAVED?: ReminderSavedListener[];
  SHOW_DETAIL?: ShowDetailListener[];
}

class EventBus {
  private listeners: ListenerStore = {};

  // --- ADD_REMINDER Event Specific Methods ---
  onAddReminder(callback: AddReminderListener): void {
    if (!this.listeners.ADD_REMINDER) {
      this.listeners.ADD_REMINDER = [];
    }
    // We know ADD_REMINDER is an array of AddReminderListener here
    (this.listeners.ADD_REMINDER as AddReminderListener[]).push(callback);
  }

  emitAddReminder(date: string): void {
    const eventListeners = this.listeners.ADD_REMINDER;
    if (eventListeners) {
      // Make a copy of the listeners array before iterating
      // to prevent issues if a listener tries to unsubscribe itself during the emit
      [...eventListeners].forEach(listener => listener(date));
    }
  }

  offAddReminder(callback: AddReminderListener): void {
    const eventListeners = this.listeners.ADD_REMINDER;
    if (eventListeners) {
      const index = eventListeners.indexOf(callback);
      if (index > -1) {
        eventListeners.splice(index, 1);
      }
    }
  }

  // --- REMINDER_SAVED Event Specific Methods ---
  onReminderSaved(callback: ReminderSavedListener): void {
    if (!this.listeners.REMINDER_SAVED) {
      this.listeners.REMINDER_SAVED = [];
    }
    (this.listeners.REMINDER_SAVED as ReminderSavedListener[]).push(callback);
  }

  emitReminderSaved(reminder: ReminderItem): void {
    const eventListeners = this.listeners.REMINDER_SAVED;
    if (eventListeners) {
      [...eventListeners].forEach(listener => listener(reminder));
    }
  }

  offReminderSaved(callback: ReminderSavedListener): void {
    const eventListeners = this.listeners.REMINDER_SAVED;
    if (eventListeners) {
      const index = eventListeners.indexOf(callback);
      if (index > -1) {
        eventListeners.splice(index, 1);
      }
    }
  }

  // --- SHOW_DETAIL Event Methods ---
  onShowDetail(callback: ShowDetailListener): void {
    if (!this.listeners.SHOW_DETAIL) {
      this.listeners.SHOW_DETAIL = [];
    }
    (this.listeners.SHOW_DETAIL as ShowDetailListener[]).push(callback);
  }

  emitShowDetail(payload: ShowDetailPayload): void {
    const eventListeners = this.listeners.SHOW_DETAIL;
    if (eventListeners) {
      [...eventListeners].forEach(listener => listener(payload));
    }
  }

  offShowDetail(callback: ShowDetailListener): void {
    const eventListeners = this.listeners.SHOW_DETAIL;
    if (eventListeners) {
      const index = eventListeners.indexOf(callback);
      if (index > -1) {
        eventListeners.splice(index, 1);
      }
    }
  }

  // 通用的发送事件方法
  emit(eventName: EventName, payload: Object): void {
    if (eventName === 'ADD_REMINDER' && typeof payload === 'string') {
      this.emitAddReminder(payload);
    } else if (eventName === 'REMINDER_SAVED') {
      // 转换为ReminderItem
      const reminderPayload = payload as ReminderItem;
      if (reminderPayload.title !== undefined) {
        this.emitReminderSaved(reminderPayload);
      }
    } else if (eventName === 'SHOW_DETAIL') {
      // 转换为ShowDetailPayload
      const detailPayload = payload as ShowDetailPayload;
      if (detailPayload.showId !== undefined) {
        this.emitShowDetail(detailPayload);
      }
    }
  }
}

export const eventBus = new EventBus();

// 定义事件常量
export const EVENTS: EventsType = {
  ADD_REMINDER: 'ADD_REMINDER',
  REMINDER_SAVED: 'REMINDER_SAVED',
  SHOW_DETAIL: 'SHOW_DETAIL'
}; 