import { PayloadAction, createAsyncThunk, createSlice } from "@reduxjs/toolkit";
import axios from "axios";

export interface Admin {
  id: string;
  admin_name: string;
  station_name: string;
  role: string;
  photo: string;
}

interface AdminState {
  data: Admin;
  loading: boolean;
  error: string | null;
}

const initialState: AdminState = {
  data: {
    id: "",
    admin_name: "",
    station_name: "",
    role: "",
    photo: "",
  },
  loading: false,
  error: null,
};

export const fetchAdmin = createAsyncThunk(
  "admin/fetch",
  async (id: string, thunkAPI) => {
    try {
      const res = await axios.get(
        `${import.meta.env.VITE_BACKEND_URL}/admin/get_admin_by_id?id=${id}`
      );
      return res.data.SUCCESS;
    } catch (error) {
      console.log(error);
      throw error;
    }
  }
);

export const AdminSlice = createSlice({
  name: "admin",
  initialState,
  reducers: {
    setAdmin: (state, action: PayloadAction<Admin>) => {
      state.data = action.payload;
      state.error = null;
    },
    clearAdmin: (state) => {
      state.data = {
        id: "",
        admin_name: "",
        station_name: "",
        role: "",
        photo: "",
      };
      state.error = null;
    },
  },
  extraReducers: (builder) => {
    builder.addCase(fetchAdmin.pending, (state, action) => {
      state.loading = true;
      state.error = null;
    });
    builder.addCase(fetchAdmin.fulfilled, (state, action) => {
      state.loading = false;
      state.data = action.payload;
      state.error = null;
    });
    builder.addCase(fetchAdmin.rejected, (state, action) => {
      state.loading = false;
      state.error = action.error.message || "An error occurred";
    });
  },
});

export const { setAdmin, clearAdmin } = AdminSlice.actions;
export default AdminSlice.reducer;
