import React from "react";
import {
  Typography,
  Box,
  Table,
  TableBody,
  TableCell,
  TableHead,
  TableRow,
  Chip,
  Stack,
  Pagination
} from "@mui/material";
import BaseCard from "../baseCard/BaseCard";

const Mydiary = (mydiarys) => {
  return (
    <BaseCard title="내가 쓴 일기들">
      <Table
        aria-label="simple table"
        sx={{
          mt: 3,
          whiteSpace: "nowrap",
        }}
      >
        <TableHead>
          <TableRow>
            <TableCell>
              <Typography color="textSecondary" variant="h6">
                번호
              </Typography>
            </TableCell>
            <TableCell>
              <Typography color="textSecondary" variant="h6">
                제목
              </Typography>
            </TableCell>
            <TableCell>
              <Typography color="textSecondary" variant="h6">
                작성일
              </Typography>
            </TableCell>
            <TableCell>
              <Typography color="textSecondary" variant="h6">
                날씨
              </Typography>
            </TableCell>         
          </TableRow>
        </TableHead>
        <TableBody>
          {mydiarys.map((product) => (
            <TableRow key={product.list.dno}>
              <TableCell>
                <Typography
                  sx={{
                    fontSize: "15px",
                    fontWeight: "500",
                  }}
                >
                  {product.list.dno}
                </Typography>
              </TableCell>
              <TableCell>
                <Box
                  sx={{
                    display: "flex",
                    alignItems: "center",
                  }}
                >
                  <Box>
                    <Typography
                      variant="h6"
                      sx={{
                        fontWeight: "600",
                      }}
                    >
                      {product.list.title}
                    </Typography>
                    <Typography
                      color="textSecondary"
                      sx={{
                        fontSize: "13px",
                      }}
                    >
                      {product.list.regdate}
                    </Typography>
                  </Box>
                </Box>
              </TableCell>
              <TableCell>
                <Typography color="textSecondary" variant="h6">
                  {product.list.weather}
                </Typography>
              </TableCell>
              <TableCell>
                <Chip
                  sx={{
                    pl: "4px",
                    pr: "4px",
                    backgroundColor: product.pbg,
                    color: "#fff",
                  }}
                  size="small"
                  label={product.priority}
                ></Chip>
              </TableCell>
              <TableCell align="right">
                <Typography variant="h6">${product.budget}k</Typography>
              </TableCell>
            </TableRow>
          ))}
        </TableBody>
      </Table>
      <Stack spacing={2}>
        <Pagination count={10} variant="outlined" color="primary" />
      </Stack>
    </BaseCard>
  );
};

export default Mydiary;
