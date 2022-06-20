import { Grid } from "@mui/material";
import BlogCard from "../src/components/dashboard/BlogCard";
import SalesOverview from "../src/components/dashboard/SalseOverview";
import DailyActivity from "../src/components/dashboard/DailyActivity";
import Mydiary from "../src/components/dashboard/Mydiary";
import {call} from "../src/service/Api-Service"

class index extends React.Component{

  constructor(props) {
    super(props);
      this.state = {items: []}; 
    }
    componentDidMount() {
      call("/myown", "GET", null).then((response) =>
      this.setState({ items: response.data })
    );
    }
    

  render() {
    return (
      <Grid container spacing={0}>
        {/* ------------------------- row 1 ------------------------- */}
        <Grid item xs={12} lg={8}>
          <Mydiary mydiarys={items}/>
          
        </Grid>
      </Grid>
    );
  }
}

export default index;
