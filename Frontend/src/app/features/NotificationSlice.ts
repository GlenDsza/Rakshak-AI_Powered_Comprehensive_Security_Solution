import { PayloadAction, createAsyncThunk, createSlice } from "@reduxjs/toolkit";
import axios from "axios";

export interface Notification {
  id: string;
  title: string;
  description: string;
  type: string;
  station_name: string;
  created_at: Date;
}

interface NotificationState {
  data: Notification[];
  loading: boolean;
  error: string | null;
}

const initialState: NotificationState = {
  data: [],
  loading: false,
  error: null,
};

export const createNotifications = createAsyncThunk(
  "notification/create",
  async (payload: Notification, thunkAPI) => {
    try {
      const res = await axios.post(
        `${import.meta.env.VITE_BACKEND_URL}/notifications/create_notification`,
        payload
      );
      return res.data.SUCCESS;
    } catch (error) {
      console.log(error);
      throw error;
    }
  }
);

export const fetchNotifications = createAsyncThunk(
  "notification/fetch",
  async (payload: { stationName: string }, thunkAPI) => {
    try {
      const { stationName } = payload;
      const res = await axios.get(
        `${
          import.meta.env.VITE_BACKEND_URL
        }/notifications/get_notifications?station_name=${stationName}`
      );
      return res.data.SUCCESS;
    } catch (error) {
      console.log(error);
      throw error;
    }
  }
);

export const readNotification = createAsyncThunk(
  "notification/read",
  async (
    payload: { station_name: string; id: string },
    thunkAPI
  ) => {
    try {
      const res = await axios.delete(
        `${import.meta.env.VITE_BACKEND_URL}/notifications/mark_as_read`,
        { data: payload }
      );
      return payload.id;
    } catch (error) {
      console.log(error);
      throw error;
    }
  }
);

export const readAllNotifications = createAsyncThunk(
  "notification/readAll",
  async (payload: { station_name: string }, thunkAPI) => {
    try {
      const res = await axios.delete(
        `${import.meta.env.VITE_BACKEND_URL}/notifications/mark_all_as_read`,
        { data: payload }
      );
      return res.data;
    } catch (error) {
      console.log(error);
      throw error;
    }
  }
);

export const NotificationSlice = createSlice({
  name: "notifications",
  initialState,
  reducers: {
    setNotifications: (state, action: PayloadAction<Notification[]>) => {
      state.data = action.payload;
      state.error = null;
    },
    clearNotifications: (state) => {
      state.data = [];
      state.error = null;
    },
  },
  extraReducers: (builder) => {
    builder.addCase(fetchNotifications.pending, (state) => {
      state.loading = true;
      state.error = null;
    });
    builder.addCase(
      fetchNotifications.fulfilled,
      (state, action: PayloadAction<Notification[]>) => {
        state.loading = false;
        state.data = action.payload;
        state.error = null;
      }
    );
    builder.addCase(fetchNotifications.rejected, (state, action) => {
      state.loading = false;
      state.error = action.error.message || null;
    });
    builder.addCase(readNotification.pending, (state) => {
      state.loading = true;
      state.error = null;
    });
    builder.addCase(
      readNotification.fulfilled,
      (state, action: PayloadAction<string>) => {
        state.loading = false;
        state.data = state.data.filter(
          (notification) => notification.id !== action.payload
        );
        state.error = null;
      }
    );
    builder.addCase(readNotification.rejected, (state, action) => {
      state.loading = false;
      state.error = action.error.message || null;
    });
    builder.addCase(readAllNotifications.pending, (state) => {
      state.loading = true;
      state.error = null;
    });
    builder.addCase(
      readAllNotifications.fulfilled,
      (state, action: PayloadAction<string>) => {
        state.loading = false;
        state.data = [];
        state.error = null;
      }
    );
    builder.addCase(readAllNotifications.rejected, (state, action) => {
      state.loading = false;
      state.error = action.error.message || null;
    });
    builder.addCase(createNotifications.pending, (state) => {
      state.loading = true;
      state.error = null;
    });
    builder.addCase(
      createNotifications.fulfilled,
      (state, action: PayloadAction<Notification>) => {
        state.loading = false;
        state.data = [...state.data, action.payload];
        state.error = null;
      }
    );
    builder.addCase(createNotifications.rejected, (state, action) => {
      state.loading = false;
      state.error = action.error.message || null;
    });
  },
});

export const { setNotifications, clearNotifications } =
  NotificationSlice.actions;
export default NotificationSlice.reducer;
