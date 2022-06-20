import { Grid } from "@mui/material";
import Mydiary from "../src/components/dashboard/Mydiary";

const Tables = () => {
  return (
    <Grid container spacing={0}>
      <Grid item xs={12} lg={12}>
        <Mydiary />
      </Grid>
    </Grid>
  );
};

export default Tables;
