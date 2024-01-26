type RowObj = {
  id: number;
  date: string;
  category: string;
  status: string;
};

const tableColumnsReport: RowObj[] = [
  {
    id: 1212,
    date: "12 Jan 2021",
    category: "Category1",
    status: "Resolved",
  },
  {
    id: 2323,
    date: "21 Feb 2021",
    category: "Category2",
    status: "Pending",
  },
  {
    id: 3434,
    date: "13 Mar 2021",
    category: "Category3",
    status: "Resolved",
  },
  {
    id: 4545,
    date: "24 Jan 2021",
    category: "Category4",
    status: "Pending",
  },
  {
    id: 5656,
    date: "24 Oct 2022",
    category: "Category5",
    status: "Resolved",
  },
  {
    id: 6767,
    date: "28 Oct 2022",
    category: "Category6",
    status: "Pending",
  },
  {
    id: 7878,
    date: "28 Oct 2022",
    category: "Category7",
    status: "Resolved",
  },
];

export default tableColumnsReport;
