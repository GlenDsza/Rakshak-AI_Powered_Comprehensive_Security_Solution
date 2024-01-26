import { PayloadAction, createAsyncThunk, createSlice } from "@reduxjs/toolkit";
import axios from "axios";

export interface Staff {
  id: string;
  staff_name: string;
  station_name: string;
  status: string;
  photo: string;
}

interface StaffState {
  data: Staff[];
  loading: boolean;
  error: string | null;
}

const initialState: StaffState = {
  data: [],
  loading: false,
  error: null,
};

export const fetchStaff = createAsyncThunk(
  "staff/fetch",
  async (payload: { stationName: string }, thunkAPI) => {
    try {
      const { stationName } = payload;
      const res = await axios.get(
        `${
          import.meta.env.VITE_BACKEND_URL
        }/staff/get_staffs_by_station?station_name=${stationName}`
      );
      return res.data.SUCCESS;
    } catch (error) {
      console.log(error);
      throw error;
    }
  }
);

export const StaffSlice = createSlice({
  name: "staff",
  initialState,
  reducers: {
    setStaff: (state, action: PayloadAction<Staff[]>) => {
      state.data = action.payload;
      state.error = null;
    },
    clearStaff: (state) => {
      state.data = [];
      state.error = null;
    },
  },
  extraReducers: (builder) => {
    builder.addCase(fetchStaff.pending, (state) => {
      state.loading = true;
      state.error = null;
    });
    builder.addCase(fetchStaff.fulfilled, (state, action) => {
      state.data = action.payload;
      state.loading = false;
      state.error = null;
    });
    builder.addCase(fetchStaff.rejected, (state, action) => {
      state.error = action.error.message || "An error occurred";
      state.loading = false;
    });
  },
});

export const { setStaff, clearStaff } = StaffSlice.actions;
export default StaffSlice.reducer;
