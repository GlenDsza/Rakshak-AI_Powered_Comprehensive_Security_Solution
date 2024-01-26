import { PayloadAction, createAsyncThunk, createSlice } from "@reduxjs/toolkit";
import axios from "axios";

export interface Incident {
  id: string;
  title: string;
  description: string;
  image: string;
  type: string;
  station_name: string;
  location: string;
  source: string;
  status: string;
  created_at: Date;
}

interface IncidentState {
  data: Incident[];
  loading: boolean;
  error: string | null;
}

const initialState: IncidentState = {
  data: [],
  loading: false,
  error: null,
};

export const fetchIncidents = createAsyncThunk(
  "incident/fetch",
  async (payload: { stationName: string }, thunkAPI) => {
    try {
      const { stationName } = payload;
      const res = await axios.get(
        `${
          import.meta.env.VITE_BACKEND_URL
        }/incidents/get_incidents_by_station?station_name=${stationName}`
      );
      return res.data;
    } catch (error) {
      console.log(error);
      throw error;
    }
  }
);

export const deleteIncident = createAsyncThunk(
  "incident/delete",
  async (payload: { id: string }, thunkAPI) => {
    try {
      const { id } = payload;
      const res = await axios.delete(
        `${import.meta.env.VITE_BACKEND_URL}/incidents/delete_incident?id=${id}`
      );
      return id;
    } catch (error) {
      console.log(error);
      throw error;
    }
  }
);

export const updateIncident = createAsyncThunk(
  "incident/update",
  async (payload: { id: string, status:string }, thunkAPI) => {
    try {
      const { id, status } = payload;
      const res = await axios.put(
        `${import.meta.env.VITE_BACKEND_URL}/incidents/update_incident_status?id=${id}&status=${status}`
      );
      return id;
    } catch (error) {
      console.log(error);
      throw error;
    }
  }
);

export const IncidentSlice = createSlice({
  name: "incidents",
  initialState,
  reducers: {
    setIncidents: (state, action: PayloadAction<Incident[]>) => {
      state.data = action.payload;
      state.error = null;
    },
    clearIncidents: (state) => {
      state.data = [];
      state.error = null;
    },
  },
  extraReducers: (builder) => {
    builder.addCase(fetchIncidents.pending, (state) => {
      state.loading = true;
      state.error = null;
    });
    builder.addCase(fetchIncidents.fulfilled, (state, action) => {
      state.data = action.payload.SUCCESS;
      state.loading = false;
      state.error = null;
    });
    builder.addCase(fetchIncidents.rejected, (state, action) => {
      state.error = action.error.message || "An error occurred";
      state.loading = false;
    });
    builder.addCase(deleteIncident.pending, (state) => {
      state.loading = true;
      state.error = null;
    });
    builder.addCase(deleteIncident.fulfilled, (state, action) => {
      state.data = state.data.filter(
        (incident) => incident.id !== action.payload
      );
      state.loading = false;
      state.error = null;
    });
    builder.addCase(deleteIncident.rejected, (state, action) => {
      state.error = action.error.message || "An error occurred";
      state.loading = false;
    });
    builder.addCase(updateIncident.pending, (state) => {
      state.loading = true;
      state.error = null;
    });
    builder.addCase(updateIncident.fulfilled, (state, action) => {
      state.data = state.data.filter(
        (incident) => incident.id !== action.payload
      );
      state.loading = false;
      state.error = null;
    });
    builder.addCase(updateIncident.rejected, (state, action) => {
      state.error = action.error.message || "An error occurred";
      state.loading = false;
    });
  },
});

export const { setIncidents, clearIncidents } = IncidentSlice.actions;
export default IncidentSlice.reducer;
